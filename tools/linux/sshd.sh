#!/bin/bash

lhn=$(hostname -s)
ldn=$(hostname -d)

echo "Generating ed25519 key for ${lhn}.${ldn}"
rm -rf /etc/ssh/ssh_host_ed25519_*
cat /dev/zero | ssh-keygen -q -N "" -t ed25519 -C "${lhn}.${ldn}" -f /etc/ssh/ssh_host_ed25519_key
cat /etc/ssh/ssh_host_ed25519_key.pub
