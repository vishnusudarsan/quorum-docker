#!/bin/sh
set -eo pipefail

geth init etc/ethereum/genesis.json

while ! (nc -w 2 bootnode 80 | grep -q 'enode'); do echo 'Waiting for bootnode...'; sleep 5; done
set +e
BOOTNODES=$(nc bootnode 80)
set -e

while ! curl -fso /dev/null --unix-socket /var/run/constellation.ipc http:/c/upcheck; do echo 'Waiting for constellation...'; sleep 5; done

echo 'unguessable' > /tmp/password

PRIVATE_CONFIG=/var/run/constellation.ipc geth \
    --bootnodes="${BOOTNODES}" \
    --mine \
    --minerthreads=1 \
    --targetgaslimit=4294967295 \
    --syncmode=full \
    --rpc \
    --rpcapi='eth,net,web3' \
    --rpcaddr='0.0.0.0' \
    --rpccorsdomain='*' \
    --etherbase=0 \
    --unlock=0 \
    --password=/tmp/password \
    --networkid=5 \
    --nat=none \
    --vmdebug \
    --verbosity=3 $@
