#!/bin/bash
# XPS_setup.sh
# openSUSE Tumbleweed - orchestration node setup for NemoClaw
# Sets up: NVIDIA driver (disables nouveau), Docker, CUDA (nvidia-container-toolkit)
#
# Usage:
#   Phase 1: Run this script, then reboot
#   Phase 2: After reboot, run: nvidia-smi && docker run --rm --gpus all nvidia/cuda:12.0-base nvidia-smi

set -euo pipefail

PHASE=${1:-1}

phase1() {
  echo "=== Phase 1: Disable nouveau, install NVIDIA driver + Docker ==="

  # Blacklist nouveau
  echo "--- Blacklisting nouveau ---"
  echo "blacklist nouveau" | sudo tee /etc/modprobe.d/50-blacklist-nouveau.conf
  sudo dracut --force --verbose

  # Add NVIDIA driver repo (G06 covers RTX 20xx/30xx/40xx)
  echo "--- Adding NVIDIA repository ---"
  sudo zypper addrepo --refresh \
    https://download.nvidia.com/opensuse/tumbleweed \
    NVIDIA 2>/dev/null || echo "NVIDIA repo already added"

  # Install NVIDIA driver
  echo "--- Installing NVIDIA driver (G06) ---"
  sudo zypper --gpg-auto-import-keys install -y --auto-agree-with-licenses \
    nvidia-video-G06 \
    nvidia-gl-G06 \
    nvidia-compute-G06

  # Install Docker
  echo "--- Installing Docker ---"
  sudo zypper install -y docker
  sudo systemctl enable docker
  sudo usermod -aG docker mansible

  # Add nvidia-container-toolkit repo
  echo "--- Adding nvidia-container-toolkit repository ---"
  sudo zypper addrepo \
    https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo \
    2>/dev/null || echo "nvidia-container-toolkit repo already added"
  sudo zypper --gpg-auto-import-keys refresh

  # Install nvidia-container-toolkit
  echo "--- Installing nvidia-container-toolkit ---"
  sudo zypper install -y --auto-agree-with-licenses nvidia-container-toolkit

  # os-prober + GRUB update
  echo "--- Installing os-prober and updating GRUB ---"
  sudo zypper install -y os-prober
  if [ -f /etc/default/grub ]; then
    # Traditional grub2 path
    sudo sed -i 's/^GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' /etc/default/grub
    grep -q 'GRUB_DISABLE_OS_PROBER' /etc/default/grub \
      || echo 'GRUB_DISABLE_OS_PROBER=false' | sudo tee -a /etc/default/grub
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg
  else
    # grub2-bls / sdbootutil path (Tumbleweed with Secure Boot)
    echo "grub2-bls detected — running os-prober and sdbootutil add-all-kernels"
    sudo os-prober || true
    sudo sdbootutil add-all-kernels || true
  fi

  echo ""
  echo "=== Phase 1 complete. REBOOT NOW, then re-run: $0 2 ==="
}

phase2() {
  echo "=== Phase 2: Post-reboot verification and Docker NVIDIA runtime config ==="

  # Verify nouveau is gone
  if lsmod | grep -q nouveau; then
    echo "ERROR: nouveau is still loaded. Reboot may not have completed correctly."
    exit 1
  fi

  # Verify NVIDIA driver
  echo "--- nvidia-smi ---"
  nvidia-smi

  # Start Docker if not running
  sudo systemctl start docker

  # Configure Docker NVIDIA runtime
  echo "--- Configuring Docker NVIDIA runtime ---"
  sudo nvidia-ctk runtime configure --runtime=docker
  sudo systemctl restart docker

  # Smoke test
  echo "--- Docker CUDA smoke test ---"
  docker run --rm --gpus all nvidia/cuda:12.6.0-base-ubuntu22.04 nvidia-smi

  echo ""
  echo "=== Phase 2 complete. Node is ready for NemoClaw. ==="
}

case "$PHASE" in
  1) phase1 ;;
  2) phase2 ;;
  *) echo "Usage: $0 [1|2]"; exit 1 ;;
esac
