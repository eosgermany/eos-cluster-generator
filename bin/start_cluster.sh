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
#rm -f ../voter_keys
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
#cleos create key >> ../voter_keys
#cleos create key >> ../voter_keys
#cleos create key >> ../voter_keys
#cleos create key >> ../voter_keys
#cleos create key >> ../voter_keys
#cleos create key >> ../voter_keys


(cd ../  && python generate.py)

echo "docker exec nodeosd cleos system newaccount eosio gi2tamigenes EOS881pU4FH2yCRA2ENKdRhUmmNihfBaB9SDW34gF9UXup6saHJ4n EOS881pU4FH2yCRA2ENKdRhUmmNihfBaB9SDW34gF9UXup6saHJ4n --stake-net '10.0000 EOS' --stake-cpu '10.0000 EOS' --buy-ram-kbytes '128 KiB'"  > ../02.1_inject_accounts.sh
echo "docker exec nodeosd cleos transfer eosio gi2tamigenes '10.0000 EOS'" >> ../02.1_inject_accounts.sh

sudo echo "p2p-peer-address = 192.168.10.26:3001" >> /data/eos-bp1/config.ini

chmod +x ../02.1_inject_accounts.sh

(cd ../  && docker-compose up -d)

sleep 3

docker exec nodeosd cleos wallet stop
# it looks that the wallet already exists!?
docker exec nodeosd rm -f /root/eosio-wallet/./default.wallet
docker exec nodeosd cleos wallet create


../00_import_keys.sh
../01_create_token.sh
../02_create_accounts.sh
../02.1_inject_accounts.sh
../04_issue_voter_token.sh
#../03_reg_producers.sh
#../05_delegate_voter_token.sh
# ../06_vote.sh

# enter container
#docker run -it \
#-v /data/bios-node:/opt/eosio/bin/data-dir \
#heipacker2016/eos:v1.0.1-unstake-5-mins-eos \
#/bin/bash
