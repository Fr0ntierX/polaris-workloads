FROM pytorch/torchserve:latest

USER root

RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Create the models folder
RUN mkdir models

# Copy the start script
COPY src/start.sh start.sh
RUN chmod +x start.sh

USER model-server

# Expose TorchServe port
EXPOSE 8080

# Start TorchServe
ENTRYPOINT ["./start.sh"]


