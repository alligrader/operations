#!/bin/bash

docker pull ghost
docker run --name ghost -v /ghost:/var/lib/ghost -p 80:2368 -d ghost
