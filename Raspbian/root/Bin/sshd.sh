#!/bin/bash

lhn=$(hostname -s)
ldn=$(hostname -d)
SSHDIR="/etc/ssh"
publicip=$(ip route | grep default | awk '{print $7}')
BACKUPDIR="/root/Backups/ssh"
PROGROOT="/home/taglio/Sources/Git/DBCTA"

if [[ ! -d "$BACKUPDIR" ]]; then
	mkdir "$BACKUPDIR"
fi

read -p "Do you want to generate ed25519 key for ${lhn}.${ldn} 1/0" ctrl
if [ "${ctrl}" = 1 ]; then
    rm -rf /etc/ssh/ssh_host_ed25519_*
    cat /dev/zero | ssh-keygen -q -N "" -t ed25519 -C "${lhn}.${ldn}" -f /etc/ssh/ssh_host_ed25519_key
fi
cat /etc/ssh/ssh_host_ed25519_key.pub
read -p "Have you copied the public ed25519 to the sshd CA host? 1/0" ctrl
if [ "${ctrl}" = 1 ]; then
    cd "$SSHDIR"
    if [[ ! -e ssh_host_ed25519_key-cert.pub ]]; then
    	wget "http://web.telecom.lobby/CA_transfer/${lhn}.${ldn}/ssh_host_ed25519_key-cert.pub"
    else
    	rm -rf ssh_host_ed25519_key-cert.pub
    	wget "http://web.telecom.lobby/CA_transfer/${lhn}.${ldn}/ssh_host_ed25519_key-cert.pub"
    fi
    cd ca
    if [[ ! -e ssh_ca_ed25519.pub ]]; then
    	wget http://web.telecom.lobby/CA_transfer/ssh_ca_ed25519.pub
    else
    	rm -rf ssh_ca_ed25519.pub
    	wget http://web.telecom.lobby/CA_transfer/ssh_ca_ed25519.pub
    fi
    cd "$SSHDIR"
    if [[ ! -d principals/ ]]; then
    	mkdir -m 750 principals/
    else
    	rm -rf principals/
    	mkdir -m 750 principals/
    fi
    echo "sudo" > principals/taglio
    chmod 0440 principals/taglio
    cd "$SSHDIR"
    install -o root -g root -m 0750 "${PROGROOT}"/Raspbian/etc/ssh/sshd_config /etc/ssh
    sed -i "s/\/PUBLICIP\//$publicip/g" sshd_config
    if [[ -e "$SSHDIR/ssh_host_rsa_key.pub" ]]; then
    	mv {ssh_host_dsa_key,ssh_host_dsa_key.pub,ssh_host_ecdsa_key,ssh_host_ecdsa_key.pub,ssh_host_rsa_key,ssh_host_rsa_key.pub} "$BACKUPDIR"
    fi
    systemctl restart sshd || error_exit "$LINENO: ERROR: sshd failed."
fi
