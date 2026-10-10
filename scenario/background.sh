#!/bin/bash
set -e

REPO=https://raw.githubusercontent.com/eryngia/dd2482-tutorial/main/scenario/assets

mkdir -p ~/demo && cd ~/demo

# Fetch project files
wget -q $REPO/app.py
wget -q $REPO/requirements.txt
wget -q -P flags $REPO/flags.json

# Start flagd
docker run -d --name flagd -p 8013:8013 -v ~/demo/flags.json:/flags.json \
  ghcr.io/open-feature/flagd:latest start --uri file:/flags.json

# Python environment
apt-get install -y python3-venv > /dev/null
python3 -m venv venv
. venv/bin/activate
pip install -q -r requirements.txt

# Signal that setup is done
touch /tmp/ready