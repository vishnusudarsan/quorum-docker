#!/bin/sh
set -eo pipefail

IP=$(hostname -i)

# Generate nodekey
mkdir -p /etc/bootnode
bootnode --genkey=/etc/bootnode/node.key

# Run simple server in the background that returns bootnode address
(while true; do echo "enode://$(bootnode -writeaddress --nodekey=/etc/bootnode/node.key)@${IP}:30301" | nc -lvp 80; done) &

# Start bootnode
bootnode --nodekey=/etc/bootnode/node.key
