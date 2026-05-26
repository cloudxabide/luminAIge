# luminAI 

Sovereign AI infrastructure that is RAG-enabled, running entirely on local hardware.

Inference runs on an NVIDIA DGX Spark (Ollama). All orchestration services run on a Dell XPS 15 9520 (SLES 16, RTX 3070 Ti Laptop GPU) via Docker Compose. RAG is sourced primarily from the public internet via self-hosted web search.

![Lets Get Some](Gemini_Generated_NUC_DGX.jpeg)

Functional Requirements

| Function | Solution |
|:---------|:---------|
| Web UI | OpenWebUI |
| RAG | Qdrant (vector DB) + SearXNG (web search) |
| Inference Engine | Ollama |
| Inference Model | Nemotron 3 Super 120B (+ others via Ollama) |
| Inference Hardware | NVIDIA DGX Spark |
| Orchestration Node | Dell XPS 15 9520 (SLES 16, RTX 3070 Ti Laptop GPU) — Docker Compose |
| Agent Framework | NemoClaw (on mini PC, inference routed to Ollama on DGX Spark) |

## Build Order

1. **Mini PC** — purchase, install SLES 16, install Docker
2. **DGX Spark** — install Ollama, pull Nemotron 3 Super 120B, verify API endpoint (`:11434`)
3. **Mini PC services** — Docker Compose with OpenWebUI + Qdrant + SearXNG, point OpenWebUI at Ollama on DGX Spark
4. **RAG** — configure OpenWebUI web search (SearXNG) and document pipeline (Qdrant)
5. **NemoClaw** — optional, add to mini PC (configure to use remote Ollama on DGX Spark at `:11434`)

[luminAI Documentation](https://luminAI.kubernerdes.com) (TBC later)
