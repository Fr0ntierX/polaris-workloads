#!/bin/bash

# Required env vars check
if [ -z "$HF_TOKEN" ]; then
    echo "Error: HF_TOKEN is not set. Please provide your Hugging Face token."
    exit 1
fi

if [ -z "$POLARIS_VLLM_MODEL" ]; then
    echo "Error: POLARIS_VLLM_MODEL is not set. Please specify the model to use."
    exit 1
fi

# Set default model variant to Q8_0 if not specified
MODEL_VARIANT=${POLARIS_MODEL_VARIANT:-Q8_0}
MODEL_PATH="$POLARIS_VLLM_DIR/$POLARIS_VLLM_MODEL-$MODEL_VARIANT"

if [ ! -d "$MODEL_PATH" ]; then
    echo "Model $POLARIS_VLLM_MODEL ($MODEL_VARIANT) not found locally. Downloading..."
    python -c "
import os
from huggingface_hub import login, snapshot_download

login(token=os.environ['HF_TOKEN'])
snapshot_download(
    repo_id=os.environ['POLARIS_VLLM_MODEL'],
    local_dir='$MODEL_PATH',
    revision='$MODEL_VARIANT'
)
    "
    echo "Model $POLARIS_VLLM_MODEL ($MODEL_VARIANT) downloaded successfully."
else
    echo "Model $POLARIS_VLLM_MODEL ($MODEL_VARIANT) already exists locally."
fi

export VLLM_HOST="0.0.0.0"
export VLLM_DEVICE="cuda"

vllm serve "$MODEL_PATH" \
    --port 8000 \
    --device $VLLM_DEVICE