#!/bin/bash

cd /home/github-runner/actions-runner

# Check if required environment variables are set
if [ -z "${REPO_URL}" ]; then
    echo "Error: REPO_URL environment variable is not set"
    exit 1
fi

if [ -z "${RUNNER_TOKEN}" ]; then
    echo "Error: RUNNER_TOKEN environment variable is not set"
    exit 1
fi

# Configure the runner
./config.sh --url ${REPO_URL} --token ${RUNNER_TOKEN} --unattended

# Start the runner
./run.sh
