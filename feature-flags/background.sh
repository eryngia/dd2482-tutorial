#!/bin/bash
set -e

REPO=https://raw.githubusercontent.com/eryngia/dd2482-tutorial/main/feature-flags/assets

mkdir -p ~/demo && cd ~/demo

# Fetch project files
wget -q $REPO/app.py
wget -q $REPO/requirements.txt
wget -q $REPO/flags.json

# Start flagd
docker run -d --name flagd -p 8013:8013 -v ~/demo/flags.json:/flags.json \
  ghcr.io/open-feature/flagd:latest start --uri file:/flags.json

# Python environment
pip install -q --break-system-packages --ignore-installed -r requirements.txt

# Start in demo folder
echo 'cd ~/demo' >> ~/.bashrc

# Signal that setup is done
touch /tmp/ready