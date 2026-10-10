#!/bin/bash

curl -s localhost:8080 | grep -q "dashboard" || { echo "The app should have the dashboard feature enabled"; exit 1; }
