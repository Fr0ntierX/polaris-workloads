# Polaris LLM - TorchServe CPU

## Overview
CPU-optimized container setup for serving machine learning models using TorchServe. Includes automatic model download and initialization.

## Building the Docker Image
Navigate to this directory and run:
```bash
cd /polaris-ai/cpu/torchserve
docker build -t torchserve-cpu .
```

## Running the Container
To start the container, use:
```bash
docker run -p 8080:8080 -e POLARIS_AI_MAR_FILE_URL="URL_TO_MODEL" torchserve-cpu
```

### Note
- The environment variable `POLARIS_AI_MAR_FILE_URL` must be set to a valid `.mar` model file URL. The model will be downloaded and stored automatically.
- On the first startup, the model download may take some time.
- You can find `.mar` model files at [TorchServe Model Zoo](https://pytorch.org/serve/model_zoo.html).

