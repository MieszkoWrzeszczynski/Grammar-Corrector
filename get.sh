#!/bin/bash
sudo docker run -dit thrax
id=$(sudo docker ps | grep thrax |  awk '{print $1}')
echo "$id"
sudo docker cp $id:/root/thrax-1.2.7/src/bin/corrector.far ./
