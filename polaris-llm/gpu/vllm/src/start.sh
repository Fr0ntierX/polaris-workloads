#!/bin/bash

if [ -z "$HF_TOKEN" ]; then
    echo "Error: HF_TOKEN is not set. Please provide your Hugging Face token."
    exit 1
fi

if [ -z "$POLARIS_VLLM_MODEL" ]; then
    echo "Error: POLARIS_VLLM_MODEL is not set. Please specify the model to use."
    exit 1
fi

if [ -z "$POLARIS_VLLM_VERSION" ]; then
    POLARIS_VLLM_VERSION="Q8_0"
    echo "No version specified. Defaulting to version $POLARIS_VLLM_VERSION."
fi

MODEL_DIR="$POLARIS_VLLM_DIR/$POLARIS_VLLM_MODEL-$POLARIS_VLLM_VERSION"

if [ ! -d "$MODEL_DIR" ]; then
    echo "Model $POLARIS_VLLM_MODEL not found locally. Downloading..."
    python -c "
import os
from huggingface_hub import login, snapshot_download

login(token=os.environ['HF_TOKEN'])

# Pobranie modelu z określoną wersją
snapshot_download(
    repo_id=os.environ['POLARIS_VLLM_MODEL'],
    local_dir=os.path.join(os.environ['POLARIS_VLLM_DIR'], os.environ['POLARIS_VLLM_MODEL'] + '-' + os.environ['POLARIS_VLLM_VERSION']),
    revision=os.environ['POLARIS_VLLM_VERSION']
)
    "
    echo "Model $POLARIS_VLLM_MODEL downloaded successfully."
else
    echo "Model $POLARIS_VLLM_MODEL already exists locally."
fi

export VLLM_HOST="0.0.0.0"
export VLLM_DEVICE="cuda"

vllm serve "$MODEL_DIR" \
    --port 8000 \
    --device $VLLM_DEVICE
