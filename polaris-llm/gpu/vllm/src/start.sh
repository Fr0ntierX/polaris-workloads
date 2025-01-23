#!/bin/bash

nvidia-smi || echo "GPU not found"

export VLLM_HOST="0.0.0.0"

export VLLM_DEVICE="cuda"

vllm serve $POLARIS_VLLM_MODEL --port 8000 --device $VLLM_DEVICE

tail -f /dev/null
