#!/bin/bash

set +x
echo "Initializing environment, please wait..."
while [ ! -f /tmp/ready ]; do sleep 1; done
clear
echo "Environment ready! You can now begin."
set -x