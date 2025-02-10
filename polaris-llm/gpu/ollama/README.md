# Polaris LLM - Ollama GPU

## Overview
This setup packages the Ollama service in a Docker container for GPU usage. It is designed to run models supported by Ollama. The model must be specified via the environment variable POLARIS_LLM_OLLAMA_MODEL.

## Building the Docker Image
Navigate to this directory:
```bash
cd /polaris-llm/gpu/ollama
docker build -t polaris-ollama-gpu .
```

## Running the Container
Supply the desired model (from Ollama's supported list) via the environment variable:
```bash
docker run -e POLARIS_LLM_OLLAMA_MODEL=ollama-model:version -d -p 11434:11434 polaris-ollama-gpu
```

### Example
To use the model "llama3.2:1b-instruct-q4_0", run:
```bash
docker run -e POLARIS_LLM_OLLAMA_MODEL=llama3.2:1b-instruct-q4_0 -d -p 11434:11434 polaris-ollama-gpu
```

## Note
- During the first startup, Ollama will download the specified model, which may take some time depending on the model's size and your internet connection.
- You can find available models at [Ollama's Model Library](https://ollama.ai/library).