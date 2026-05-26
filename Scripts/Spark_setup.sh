#!/bin/bash

# You should start open-webui:ollama - using "../bin/ollamactl start"

# Pull the Nemotron-3 model
docker exec -it $(docker ps -a | grep ollama | awk '{ print $1 }') "ollama pull nemotron-3-super:120b"
# OR (this needs to be tested)
docker exec -it $(docker ps -q -f "name=ollama" | head -n 1) ollama pull nemotron-3-super:120b
