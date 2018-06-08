#!/bin/bash

sudo rm -rf ./tmp
mkdir ./tmp
cp ../genesis.json ./tmp
docker kill eosgermanybp

#genesis:9876
#bp10:9865
#nodeos --genesis-json=./genesis.json \
#       --data-dir=./data --config-dir=./config \
#       --p2p-peer-address=localhost:9865 \
#       --p2p-peer-address=localhost:9876 \
#       --http-server-address=localhost:3000 \
#       --p2p-listen-endpoint=localhost:3001


#nodeos \
#  --data-dir /home/jj/projects/eosgermany/eos-testbed/single/chain_3/data \
#  --genesis-json /home/jj/projects/eosgermany/eos-testbed/single/chain_3/genesis.json \
#  --replay-blockchain \
#  --p2p-peer-address=localhost:9865 \
#  --p2p-peer-address=localhost:9876 \
#  --http-server-address=localhost:3000 \
#  --p2p-listen-endpoint=localhost:3001

#docker run -ti \
#-v /data/bios-node:/opt/eosio/bin/data-dir \
#heipacker2016/eos:v1.0.1-unstake-5-mins-eos /bin/bash

#docker run -ti --rm --detach --name nodeos-bios \
#       -v `pwd`:/etc/nodeos -v /tmp/nodeos-data:/data \
#       -p 8888:8888 -p 9876:9876 \
#       eosgermany/eos:DAWN-2018-05-30 \
#       /opt/eosio/bin/nodeos --data-dir=/data \
#                             --config-dir=/etc/nodeos \
#                             --genesis-json=/etc/nodeos/genesis.json \
#                             --enable-stale-production \
#                             --max-irreversible-block-age=1000000
#                             #--p2p-listen-endpoint=127.0.0.1:65432 \
#                             #--max-transaction-time=5000


#/opt/eosio/bin/nodeosd.sh
#/opt/eosio/bin/nodeos

#docker run -ti heipacker2016/eos:v1.0.1-unstake-5-mins-eos /bin/bash
#command: nodeosd.sh --data-dir /opt/eosio/bin/data-dir --genesis-json /opt/e

#nodeos \
#  --data-dir /home/jj/projects/eosgermany/eos-testbed/single/chain_3/data \
#  --genesis-json /home/jj/projects/eosgermany/eos-testbed/single/chain_3/genesis.json \
#  --replay-blockchain \
#  --p2p-peer-address=localhost:9865 \
#  --p2p-peer-address=localhost:9876 \
#  --http-server-address=localhost:3000 \
#  --p2p-listen-endpoint=localhost:3001

cp ../config.ini_eosgermany ./tmp/

docker run -ti  \
    --network=host \
    -v `pwd`/tmp:/data -v `pwd`/tmp:/conf \
    heipacker2016/eos:v1.0.1-unstake-5-mins-eos \
    /opt/eosio/bin/nodeos \
    --genesis-json /conf/genesis.json \
    --data-dir /data \
    --config-dir /conf \
    --config config.ini_eosgermany \
    --http-server-address=0.0.0.0:3000 \
    --p2p-listen-endpoint=0.0.0.0:3001 \
    --p2p-peer-address=192.168.10.26:9865 \
    --p2p-peer-address=192.168.10.26:9876

#docker run -ti  \
#        --network=eos-cluster-generator_default \
#        -v `pwd`/tmp:/data -v `pwd`/tmp:/conf \
#        heipacker2016/eos:v1.0.1-unstake-5-mins-eos \
#        /bin/bash
