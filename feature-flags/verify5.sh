#!/bin/bash

for variant in classic compact split; do
    found=false

    for i in $(seq 1 100); do
        if curl -s "localhost:8080?email=user${i}@example.com" | grep -q "$variant"; then
            found=true
            break
        fi
    done

    $found || exit 1
done