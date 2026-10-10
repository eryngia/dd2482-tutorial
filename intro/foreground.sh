#!/bin/bash

while [ ! -f /tmp/ready ]; do sleep 1; done
echo "Environment ready"