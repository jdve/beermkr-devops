#!/bin/bash

# Source this script to get create_user()
#
# Creates a user capable of sudo, and writes to their authorized_keys file
#
# Usage:
# create_user <username> < <ssh_public_key>

set -euo pipefail

create_user () {
  local username=${1:-invalid}

  # from https://unix.stackexchange.com/questions/230673/how-to-generate-a-random-string
  password=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13)

  sudo useradd \
    --user-group \
    --create-home \
    --groups sudo,users,wheel \
    --shell /bin/bash \
    --password "$password" \
    "$username"

  sudo mkdir -p "/home/$username/.ssh"
  sudo chown "$username:$username" "/home/$username/.ssh"

  while read authorized_key; do
    echo "$authorized_key" | sudo -u "$username" tee -a "/home/$username/.ssh/authorized_keys"
  done
}
