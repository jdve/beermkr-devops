#!/bin/bash

# Creates user accounts for developers

set -euo pipefail

curl --silent https://github.com/robacarp.keys \
  | create_user robert

curl --silent https://github.com/jdve.keys \
  | create_user jonathan
