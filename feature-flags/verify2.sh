#!/bin/bash

curl -s localhost:8080 | grep -q "dark-mode" || { echo "The app should have the dark-mode feature enabled"; exit 1; }
