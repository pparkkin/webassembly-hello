FROM ubuntu:xenial

# Install prerequisites
RUN apt update && apt install -y \
  git \
  python \
  cmake

# Install emsdk
RUN git clone https://github.com/juj/emsdk.git
RUN /emsdk/emsdk install latest
RUN /emsdk/emsdk activate latest

# Build example
COPY hello-world-c /webassembly-test/hello-world-c/
WORKDIR /webassembly-test/hello-world-c
RUN /bin/bash -c "source /emsdk/emsdk_env.sh --build=Release \
  && emcc hello.c -s WASM=1 -o hello.js"

WORKDIR /webassembly-test
ENTRYPOINT /bin/bash -c "source /emsdk/emsdk_env.sh --build=Release \
  && emrun --no_browser --host=0.0.0.0 --port=8080 ."
