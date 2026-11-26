# ===================================================================
# Dockerfile — Run COBOL QUEST anywhere (macOS, Linux, or Windows)
# without installing anything on your host OS!
#
# Usage:
#   docker build -t cobol-quest .
#   docker run -it --rm cobol-quest
# ===================================================================
FROM ubuntu:24.04

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      gnucobol \
      ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

RUN ./scripts/build-unix.sh --build-only

CMD ["./bin/cobol-quest"]
