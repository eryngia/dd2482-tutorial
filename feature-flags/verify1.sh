#!/bin/bash

curl -s localhost:8080 | grep -q "none" || { echo "The app should be running without any enabled features"; exit 1; }
