# syntax=docker/dockerfile:1

FROM alpine:latest

# Install curl and tar
RUN apk add --no-cache curl tar

WORKDIR /app

# Fetch the latest release tarball URL from GitHub API and download/extract it
RUN set -eux; \
    LATEST_URL=$(curl -s https://api.github.com/repos/mongodb/kingfisher/releases/latest \
      | grep "browser_download_url.*linux-x64.tgz" \
      | cut -d '"' -f 4); \
    curl -L "$LATEST_URL" -o kingfisher.tgz; \
    tar -xzf kingfisher.tgz; \
    rm kingfisher.tgz

# List files for debug (optional, can be removed)
RUN ls -l /app

# Set entrypoint to kingfisher binary (assuming it's named 'kingfisher' after extraction)
ENTRYPOINT ["/app/kingfisher"]
