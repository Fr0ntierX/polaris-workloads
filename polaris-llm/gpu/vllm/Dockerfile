FROM python:3.9-slim

ENV HF_LOGIN=""
ENV HF_TOKEN=""
ENV POLARIS_VLLM_MODEL="12"
ENV POLARIS_VLLM_DIR="/models"
ENV test="1234"

RUN apt-get update && apt-get install -y \
    git \
    net-tools \
    build-essential \
    python3-dev \
    kmod \
    cmake \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir huggingface_hub vllm transformers

RUN mkdir -p $POLARIS_VLLM_DIR
WORKDIR $POLARIS_VLLM_DIR

COPY src/start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

EXPOSE 8000

CMD ["/opt/start.sh"]