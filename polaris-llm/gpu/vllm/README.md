# Polaris LLM - vllm GPU

This setup provides a Docker container for running vLLM on a GPU. A start script ensures that all required environment variables are set, downloads the specified model if necessary, and serves it via vLLM.

## Prerequisites

Ensure that:

- HF_TOKEN: Your Hugging Face token.
- POLARIS_VLLM_MODEL: The model identifier.
- POLARIS_VLLM_DIR: (Optional) Directory for model storage (default: /models).

## Building the Docker Image

Navigate to this directory and run:

```bash
cd /polaris-llm/gpu/vllm
docker build -t polaris-vllm:latest .
```

## Running the Container

Start the container while supplying the necessary environment variables. For example:

```bash
docker run -e HF_TOKEN=your_token \
           -e POLARIS_VLLM_MODEL=your_model_id \
           -p 8000:8000 polaris-vllm:latest
```

Example run command:

```bash
docker run -e HF_TOKEN=hf_token \
           -e POLARIS_VLLM_MODEL=meta-llama/Llama-3.1-8B-Instruct \
           -p 8000:8000 polaris-vllm:latest
```



## Models
Models are sourced from [HuggingFace Hub](https://huggingface.co/models). Some models require special access:


To access gated models:

1. Find your desired model on [HuggingFace Hub](https://huggingface.co/models)

2. Request access from model provider if required

3. Accept terms on HuggingFace hub

4. Use your HF_TOKEN for authentication

## Note
On first startup, if the model is not present under POLARIS_VLLM_DIR, the container will attempt to download it. This may take some time depending on the model size and your internet connection.

