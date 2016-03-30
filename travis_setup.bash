#!/bin/bash
echo $MY_PASS > /tmp/pass.txt
wget https://s3.amazonaws.com/sumo-travisci/travisci.enc -O travisci.enc
openssl aes-256-cbc -in travisci.enc -out /tmp/travisci.pem -pass "file:/tmp/pass.txt"  -d
chmod 600 /tmp/travisci.pem
cat /tmp/travisci.pem
