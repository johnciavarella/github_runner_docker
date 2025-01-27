# github_runner_docker
A docker for github selfhosted runners

## Docker run

```
docker run github-runner \
-d \
-e REPO_URL={your_github_repo} \
-e RUNNER_TOKEN={your_runner_token} 
```

## Docker Compose 

```
name: Github Selfhosted Runner
services:
    github-runner:
        image: github-runner
        environment:
            REPO_URL={your_github_repo}
            RUNNER_TOKEN={your_runner_token}
```

## Build from dockerfile 

clone repo and run this from that directory  
```
docker build -t github-runner .
```