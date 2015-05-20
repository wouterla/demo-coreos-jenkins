#!/bin/bash
echo "Clean..."
rm -rf build && mkdir build

echo "Copying docker files"
cp docker/docker-base/* build/

echo "Running docker"
cd build
docker build -t wouterla/docker-base .

echo "Pushing docker image to repository"
docker push wouterla/docker-base
