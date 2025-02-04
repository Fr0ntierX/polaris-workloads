#!/bin/bash

if [ -z "$HF_TOKEN" ]; then
    echo "Error: HF_TOKEN is not set. Please provide your Hugging Face token."
    exit 1
fi

if [ -z "$POLARIS_VLLM_MODEL" ]; then
    echo "Error: POLARIS_VLLM_MODEL is not set. Please specify the model to use."
    exit 1
fi

if [ ! -d "$POLARIS_VLLM_DIR/$POLARIS_VLLM_MODEL" ]; then
    echo "Model $POLARIS_VLLM_MODEL not found locally. Downloading..."
    python -c "
import os
from huggingface_hub import login, snapshot_download

login(token=os.environ['HF_TOKEN'])
snapshot_download(
    repo_id=os.environ['POLARIS_VLLM_MODEL'],
    local_dir=os.path.join(os.environ['POLARIS_VLLM_DIR'], os.environ['POLARIS_VLLM_MODEL']),
    revision='main'
)
    "
    echo "Model $POLARIS_VLLM_MODEL downloaded successfully."
else
    echo "Model $POLARIS_VLLM_MODEL already exists locally."
fi

export VLLM_HOST="0.0.0.0"
export VLLM_DEVICE="cuda"

vllm serve "$POLARIS_VLLM_MODEL" \
    --port 8000 \
    --device $VLLM_DEVICE