#!/bin/bash

# works on ubuntu 16.04
# ifconfig enp2s0 | grep 'inet addr:' | cut -d: -f2 | awk '{ printf $1}' > ../config.py

# stop all containers
docker stop $(docker ps -aq)

# remove previous cluster
sudo rm -rf /data/*
sudo chown -R $USER /data

rm -f ../bios_keys
rm -f ../token_keys
rm -f ../bp_keys
rm -f ../voter_keys
rm -f ../*.sh

# bios & tokens
cleos create key > ../bios_keys
cleos create key > ../token_keys

# producers
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
cleos create key >> ../bp_keys
#cleos create key >> ../bp_keys


# voters
cleos create key >> ../voter_keys
cleos create key >> ../voter_keys
cleos create key >> ../voter_keys
#cleos create key >> ../voter_keys
#cleos create key >> ../voter_keys
#cleos create key >> ../voter_keys




(cd ../  && python generate.py)

(cd ../  && docker-compose up -d)

sleep 3

docker exec nodeosd cleos wallet stop
# it looks that the wallet already exists!?
docker exec nodeosd rm -f /root/eosio-wallet/./default.wallet
docker exec nodeosd cleos wallet create


../00_import_keys.sh
../01_create_token.sh
../02_create_accounts.sh
../03_reg_producers.sh
../04_issue_voter_token.sh

# enter container
#docker run -it \
#-v /data/bios-node:/opt/eosio/bin/data-dir \
#heipacker2016/eos:v1.0.1-unstake-5-mins-eos \
#/bin/bash
