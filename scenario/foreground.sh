#!/bin/bash

# Wait for background to finish
while [ ! -f /tmp/ready ]; do sleep 1; done
echo "Environment ready"