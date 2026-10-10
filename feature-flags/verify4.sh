#!/bin/bash

curl -s "localhost:8080?email=alice@company.com" | grep -q "dashboard"
! curl -s "localhost:8080?email=bob@gmail.com" | grep -q "dashboard"