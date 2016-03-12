#!/usr/bin/env bash

sudo lsof -i :53
sudo apt-get update
sudo apt-get -y install docker.io

bundle install
