#!/bin/bash

docker run --rm \
  -p 3000:3000 \
  -v $PWD/adylay:/home \
  -w /home \
  server-utils \
  morbo ./script/adylay daemon
