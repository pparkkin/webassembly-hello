FROM ubuntu:xenial

RUN apt update && apt install -y \
  git \
  python \
  cmake

RUN git clone https://github.com/juj/emsdk.git

RUN /emsdk/emsdk install latest
RUN /emsdk/emsdk activate latest

COPY . /webassembly-test/

WORKDIR /webassembly-test/hello-world-c
RUN /bin/bash -c "source /emsdk/emsdk_env.sh --build=Release \
  && emcc hello.c -s WASM=1 -o hello.js"

WORKDIR /webassembly-test
ENTRYPOINT /bin/bash -c "source /emsdk/emsdk_env.sh --build=Release \
  && emrun --no_browser --host=0.0.0.0 --port=8080 ."
