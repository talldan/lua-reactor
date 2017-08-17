#!/usr/bin/env bash
./test.sh
fswatch -o ./ | xargs -n1 ./test.sh