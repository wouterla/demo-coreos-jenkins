#!/bin/bash

set -e

ETCD="etcdctl --peers=$ETCD_ENDPOINT"

if [ "$#" -ne 3 ]; then
    echo "Usage: collect-endpoints.sh <environment> <application> <hash>"
    exit 1
fi

etcd_key="/demo/instances/$1/$2/$3"

ENDPOINTS=()

for instance in $($ETCD ls $etcd_key); do
  endpoint=$($ETCD get $instance)

  ENDPOINTS+=($endpoint)
done

echo ${ENDPOINTS[@]}
