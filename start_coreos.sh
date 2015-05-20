#!/bin/bash
set -x

# Start Docker Registry on the local host
sudo docker run -d \
    --name docker-registry \
    -p 5000:5000 \
    -v $(pwd)/registry:/tmp/registry \
    -e STANDALONE=false \
    -e MIRROR_SOURCE=https://registry-1.docker.io \
    -e MIRROR_SOURCE_INDEX=https://index.docker.io \
    registry:latest

vagrant up
export FLEETCTL_TUNNEL=172.17.8.101
rm $HOME/.fleetctl/known_hosts
ssh-add $HOME/.vagrant.d/insecure_private_key

# Wait a bit for things to start
sleep 10

fleetctl -strict-host-key-checking=false start coreos/vulcand.service
fleetctl -strict-host-key-checking=false start coreos/jenkins.service
fleetctl -strict-host-key-checking=false start coreos/jenkins-job-builder.service
fleetctl -strict-host-key-checking=false list-units
