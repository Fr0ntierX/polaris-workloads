#!/bin/bash

# Run Ollama
export OLLAMA_HOST="0.0.0.0"
ollama serve &
ollama list
ollama run $POLARIS_LLM_OLLAMA_MODEL --verbose --keepalive 24h
