FROM alpine:latest

ARG LOOPHOLE_VERSION=1.0.0-beta.15
ARG PLATFORM=linux_arm64
RUN apk add --no-cache curl tar

WORKDIR /tmp

RUN curl -L "https://github.com/loophole/cli/releases/download/${LOOPHOLE_VERSION}/loophole-cli_${LOOPHOLE_VERSION}_${PLATFORM}.tar.gz" -o loophole-cli.tar.gz

# Extract the loophole binary and move it to /usr/local/bin
RUN tar -xzf loophole-cli.tar.gz \
    && mv loophole-cli_${LOOPHOLE_VERSION}_${PLATFORM}/loophole /usr/local/bin/ \
    && chmod +x /usr/local/bin/loophole

RUN rm -rf /tmp/*

ENTRYPOINT ["loophole"]
