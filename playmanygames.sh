#!/bin/bash

while true; do
  git pull;
  bundle exec rtanque start bots/* sample_bots/camper sample_bots/seek_and_destroy sample_bots/keyboard;
done