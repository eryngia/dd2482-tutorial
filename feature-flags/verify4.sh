#!/bin/bash

curl -s "localhost:8080?email=alice@company.com" | grep -q "dashboard" || { echo "alice@company.com should see the dashboard"; exit 1; }
curl -s "localhost:8080?email=bob@gmail.com" | grep -q "dashboard" && { echo "bob@gmail.com should not see the dashboard"; exit 1; }
