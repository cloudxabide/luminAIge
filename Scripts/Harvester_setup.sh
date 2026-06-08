#!/bin/bash
# Harvester_setup.sh
# Post-kubeconfig deployment helper for the luminAIge stack on Harvester (RKE2).
#
# Prerequisites (completed via Harvester UI / Rancher before running this script):
#   1. Three nodes booted from Harvester ISO and joined into a cluster
#   2. RKE2 guest cluster created via Harvester -> Virtualization Management -> Clusters
#   3. kubeconfig downloaded and placed at ~/.kube/config (or KUBECONFIG)
#   4. k8s/configmap.yaml updated with correct DGX_SPARK_IP and HARVESTER_IP
#   5. k8s/secret.yaml created from k8s/secret.example.yaml with real values
#
# Usage:
#   Phase 1: validate prereqs and deploy
#   Phase 2: post-deploy status check

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
K8S_DIR="${SCRIPT_DIR}/../k8s"
PHASE=${1:-1}

phase1() {
  echo "=== Phase 1: Validate prerequisites and deploy luminAIge to RKE2 ==="

  # Verify kubectl is available
  if ! command -v kubectl &>/dev/null; then
    echo "ERROR: kubectl not found. Install it and ensure KUBECONFIG is set."
    exit 1
  fi

  # Verify cluster is reachable
  echo "--- Checking cluster connectivity ---"
  kubectl cluster-info

  # Verify secret.yaml exists
  if [[ ! -f "${K8S_DIR}/secret.yaml" ]]; then
    echo "ERROR: ${K8S_DIR}/secret.yaml not found."
    echo "  cp ${K8S_DIR}/secret.example.yaml ${K8S_DIR}/secret.yaml"
    echo "  # then fill in real values (base64-encoded)"
    exit 1
  fi

  # Create NGC image pull secret so Kubernetes can pull from nvcr.io
  echo "--- Creating NGC image pull secret ---"
  if [[ -z "${NGC_API_KEY:-}" ]]; then
    echo "WARNING: NGC_API_KEY not set — skipping ngc-registry secret creation."
    echo "  Export NGC_API_KEY and re-run, or create the secret manually:"
    echo "  kubectl create secret docker-registry ngc-registry \\"
    echo "    --docker-server=nvcr.io \\"
    echo "    --docker-username='\$oauthtoken' \\"
    echo "    --docker-password=<NGC_API_KEY> \\"
    echo "    -n luminaige"
  else
    kubectl create namespace luminaige --dry-run=client -o yaml | kubectl apply -f -
    kubectl create secret docker-registry ngc-registry \
      --docker-server=nvcr.io \
      --docker-username='$oauthtoken' \
      --docker-password="${NGC_API_KEY}" \
      -n luminaige \
      --dry-run=client -o yaml | kubectl apply -f -
    echo "ngc-registry secret created/updated."
  fi

  # Apply the full stack via kustomize
  echo "--- Applying luminAIge manifests ---"
  kubectl apply -k "${K8S_DIR}"

  echo ""
  echo "=== Phase 1 complete. Run '$0 2' to check rollout status. ==="
}

phase2() {
  echo "=== Phase 2: Rollout status and service endpoints ==="

  kubectl rollout status deployment/openwebui  -n luminaige --timeout=120s
  kubectl rollout status deployment/searxng    -n luminaige --timeout=120s
  kubectl rollout status deployment/nemoclaw   -n luminaige --timeout=120s
  kubectl rollout status statefulset/qdrant    -n luminaige --timeout=120s

  echo ""
  echo "--- Pod status ---"
  kubectl get pods -n luminaige

  echo ""
  echo "--- Service endpoints ---"
  kubectl get svc -n luminaige

  echo ""
  OWUI_IP=$(kubectl get svc openwebui -n luminaige \
    -o jsonpath='{.status.loadBalancer.ingress[0].ip}' 2>/dev/null || true)
  if [[ -n "$OWUI_IP" ]]; then
    echo "OpenWebUI: http://${OWUI_IP}:3000"
  else
    echo "OpenWebUI LoadBalancer IP not yet assigned — check: kubectl get svc openwebui -n luminaige"
  fi

  echo ""
  echo "=== Phase 2 complete. Harvester/RKE2 + NemoClaw stack is ready. ==="
}

case "$PHASE" in
  1) phase1 ;;
  2) phase2 ;;
  *) echo "Usage: $0 [1|2]"; exit 1 ;;
esac
