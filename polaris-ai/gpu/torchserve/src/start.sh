#!/bin/bash

# Download the model
wget $POLARIS_AI_MAR_FILE_URL -O model-store/model.mar

# Run TorchServe
torchserve --start --model-store model-store --models all --foreground --disable-token-auth
