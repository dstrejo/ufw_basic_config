#!/bin/bash

# Function to set up basic firewall rules
setup_firewall() {
    echo "Setting up basic firewall rules..."
    ufw default deny incoming
    ufw default allow outgoing
    ufw allow ssh
    ufw allow http
    ufw allow https
    ufw enable   
    echo -e "Basic firewall rules set up.\n"
    ufw status
}

# Function to apply SSH restrictions
restrict_ssh() {
    echo "Applying SSH restrictions..."
    ufw allow from 192.168.178.0/24 to any port 22
    echo "SSH restrictions applied."
}

# Function to block unnecessary ports
block_ports() {
    echo "Blocking unnecessary ports..."
    # Block ports 23 (telnet), 25 (SMTP), 445 (SMB), 20/21 (FTP), 3306 (MYSQL)
    for port in 23 25 445 20 21 3306; do
	    ufw deny $port
    echo "Unnecessary ports blocked."
done
}

# Function to enable logging
enable_logging() {
    echo "Enabling firewall logging..."
    ufw logging on
    echo "Firewall logging enabled."
}

# Main script execution
restrict_ssh
block_ports
enable_logging
setup_firewall
