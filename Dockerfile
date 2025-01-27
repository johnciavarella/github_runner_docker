# Use Ubuntu as the base image
FROM ubuntu:25.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    jq \
    sudo \
    git \
    libicu74 \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user for the runner
RUN useradd -m github-runner \
    && usermod -aG sudo github-runner \
    && echo "github-runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the github-runner user
USER github-runner
WORKDIR /home/github-runner

# Create actions-runner directory and download the runner package
RUN mkdir actions-runner && cd actions-runner \
    && curl -o actions-runner-linux-x64-2.321.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.321.0/actions-runner-linux-x64-2.321.0.tar.gz \
    && echo "ba46ba7ce3a4d7236b16fbe44419fb453bc08f866b24f04d549ec89f1722a29e  actions-runner-linux-x64-2.321.0.tar.gz" | shasum -a 256 -c \
    && tar xzf ./actions-runner-linux-x64-2.321.0.tar.gz \
    && rm actions-runner-linux-x64-2.321.0.tar.gz

# Copy the entrypoint script
COPY --chown=github-runner:github-runner entrypoint.sh /home/github-runner/entrypoint.sh
RUN sudo chmod +x /home/github-runner/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/home/github-runner/entrypoint.sh"]
