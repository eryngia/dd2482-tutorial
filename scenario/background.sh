#!/bin/bash
set -e

# Start flagd
docker run -d --name flagd -p 8013:8013 -v ~/demo/flags:/flags \
  ghcr.io/open-feature/flagd:latest start --uri file:/flags/flags.json

# Python environment
apt-get install -y python3-venv > /dev/null
python3 -m venv venv
. venv/bin/activate
pip install -q -r requirements.txt

# Signal that setup is done
touch /tmp/ready