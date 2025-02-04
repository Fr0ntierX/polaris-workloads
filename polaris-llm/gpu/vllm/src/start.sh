#!/bin/bash

if [ -z "$HF_TOKEN" ]; then
    echo "Error: HF_TOKEN is not set. Please provide your Hugging Face token."
    exit 1
fi

if [ -z "$POLARIS_VLLM_MODEL" ]; then
    echo "Error: POLARIS_VLLM_MODEL is not set. Please specify the model to use."
    exit 1
fi

# Set cache directories
export HF_HOME="/mnt/models/.cache/huggingface"
export TRANSFORMERS_CACHE="/mnt/models/.cache/torch"
MODEL_PATH="$POLARIS_VLLM_DIR/$POLARIS_VLLM_MODEL"

if [ ! -d "$MODEL_PATH" ]; then
    echo "Model $POLARIS_VLLM_MODEL not found locally. Downloading to $MODEL_PATH..."
    python -c "
import os
from huggingface_hub import login, snapshot_download

login(token=os.environ['HF_TOKEN'])
snapshot_download(
    repo_id=os.environ['POLARIS_VLLM_MODEL'],
    local_dir=os.environ['MODEL_PATH'],
    cache_dir=os.environ['HF_HOME'],
    revision='main'
)
    "
    echo "Model $POLARIS_VLLM_MODEL downloaded successfully."
else
    echo "Model $POLARIS_VLLM_MODEL already exists locally."
fi

export VLLM_HOST="0.0.0.0"
export VLLM_DEVICE="cuda"

vllm serve "$MODEL_PATH" \
    --port 8000 \
    --device $VLLM_DEVICE