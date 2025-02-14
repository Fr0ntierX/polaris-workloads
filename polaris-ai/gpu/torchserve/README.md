# Polaris LLM - TorchServe GPU

GPU-accelerated container setup for high-performance model serving using TorchServe. Features automated model management and CUDA optimization.

## Building the Docker Image
Navigate to this directory and run:
```bash
cd polaris-ai/gpu/torchserve
docker build -t torchserve-gpu .
```

## Running the Container
To start the container, use:
```bash
docker run -p 8080:8080 -e POLARIS_AI_MAR_FILE_URL="URL_TO_MODEL" torchserve-gpu
```

### Note
- The environment variable `POLARIS_AI_MAR_FILE_URL` must be set to a valid `.mar` model file URL. The model will be downloaded and stored automatically.
- On the first startup, the model download may take some time.
- You can find `.mar` model files at [TorchServe Model Zoo](https://pytorch.org/serve/model_zoo.html).

