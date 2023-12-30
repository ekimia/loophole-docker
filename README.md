# Loophole for Docker

This repository enables you to run Loophole using Docker, or more effectively with Docker Compose, allowing for the automatic exposure of a service when executing the `docker-compose up` command.

# Prerequisities
Loophole installed and logged in locally via `loophole account login` to snag the access token off of the host.


# Usage
Make sure you pick the image with the correct platform for your host

_docker-compose.yml_
```
version: '3'

services:
  api-service:
    build:
      context: .
      dockerfile: Dockerfile
    env_file: .env
    volumes:
      - ./src:/src
    ports:
      - "8000:8000"

  loophole:
    image: ekimiadocker/loophole:1.0.0-beta.15_linux_arm64
    restart: on-failure
    network_mode: service:api-service
    depends_on:
      - api-service
    command: http 8000 --hostname optional-unique-subdomain
    volumes:
      - ~/.loophole/tokens.json:/root/.loophole/tokens.json
```
