#!/usr/bin/env bash

sudo apt-get install docker
bundle install
bundle exec rspec spec/
