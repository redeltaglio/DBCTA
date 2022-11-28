#!/bin/bash

lhn=$(hostname -s)
ldn=$(hostname -d)

read -p "Do you want to generate ed25519 key for ${lhn}.${ldn} 1/0" ctrl
if [ "${ctrl}" = 1 ]; then
    rm -rf /etc/ssh/ssh_host_ed25519_*
    cat /dev/zero | ssh-keygen -q -N "" -t ed25519 -C "${lhn}.${ldn}" -f /etc/ssh/ssh_host_ed25519_key
else
    exit 1
fi
cat /etc/ssh/ssh_host_ed25519_key.pub
read -p "Have copied the public ed25519 to the sshd CA host? 1/0" ctrl
if [ "${ctrl}" = 1 ]; then

else
    exit 1
fi
