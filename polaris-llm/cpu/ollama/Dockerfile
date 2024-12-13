FROM ubuntu:24.04

# Install dependencies and Ollama
RUN apt update && apt upgrade -y && \
  apt install curl -y && \
  curl -fsSL https://ollama.com/install.sh | sh && \
  apt clean && rm -rf /var/lib/apt/lists/*

# Prepare Ollama
ENV POLARIS_LLM_OLLAMA_MODEL=llama3.2:1b-instruct-q4_0

COPY src/start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

EXPOSE 11434

CMD ["/opt/start.sh"]
