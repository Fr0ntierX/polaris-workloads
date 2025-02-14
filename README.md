# Polaris Workloads

Collection of containerized AI/ML workloads optimized for deployment in Polaris Containers. Includes CPU and GPU variants for different use cases.

## Workloads

### 1. TorchServe
- [**CPU Version**](polaris-ai/cpu/torchserve/README.md)  
  - Location: `/polaris-ai/cpu/torchserve` 
  - Overview: Sets up TorchServe for CPU workloads. The start script downloads the model and starts the service.  

- [**GPU Version**](polaris-ai/gpu/torchserve/README.md)  
  - Location: `/polaris-ai/gpu/torchserve`  
  - Overview: Sets up TorchServe for GPU workloads using a GPU-enabled TorchServe image.  

### 2. Language Models
- [**Ollama CPU**](polaris-llm/cpu/ollama/README.md)  
  - Location: `/polaris-llm/cpu/ollama`  
  - Overview: Packages the Ollama service in a Docker container for CPU usage. Specify the model via the `POLARIS_LLM_OLLAMA_MODEL` environment variable.

- [**Ollama GPU**](polaris-llm/gpu/ollama/README.md)  
  - Location: `/polaris-llm/gpu/ollama`  
  - Overview: GPU-accelerated version of Ollama service. Uses NVIDIA CUDA for model inference.
  - Prerequisites:
    - `POLARIS_LLM_OLLAMA_MODEL`: The model identifier.

- [**vLLM GPU**](polaris-llm/gpu/vllm/README.md) 
  - Location: `/polaris-llm/gpu/vllm`  
  - Overview: Sets up vllm in a Docker container for GPU usage. The start script validates required environment variables, downloads the specified model (if needed), and launches vllm.
  - Prerequisites:  
    - `HF_TOKEN`: Your Hugging Face token.  
    - `POLARIS_VLLM_MODEL`: The model identifier.  
    - `POLARIS_VLLM_DIR`: (Optional) Directory for model storage (default: `/models`).

## Additional Notes
- On first startup, if the specified model is not already present, the related workload will automatically download it (this may take some time depending on the model size and connection speed).  
- Refer to each workload's README for more detailed instructions and configuration options.

