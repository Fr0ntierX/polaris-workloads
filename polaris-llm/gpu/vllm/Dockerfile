FROM python:3.9-slim

ARG HF_LOGIN
ARG HF_TOKEN
ARG POLARIS_VLLM_MODEL

ENV HF_LOGIN=$HF_LOGIN
ENV HF_TOKEN=$HF_TOKEN
ENV POLARIS_VLLM_MODEL=$POLARIS_VLLM_MODEL
ENV POLARIS_VLLM_DIR="/models"

RUN apt-get update && apt-get install -y \
    git \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir huggingface_hub vllm

RUN mkdir -p $POLARIS_VLLM_DIR
WORKDIR $POLARIS_VLLM_DIR

# Use Hugging Face Hub to download the model
RUN python -c "import os; from huggingface_hub import login, snapshot_download; \
    login(token=os.environ['HF_TOKEN']); \
    snapshot_download(repo_id=os.environ['POLARIS_VLLM_MODEL'], local_dir=os.environ['POLARIS_VLLM_DIR'], revision='main')"

COPY src/start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

EXPOSE 8000

CMD ["/opt/start.sh"]