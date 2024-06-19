#!/bin/bash

# Set up basic firewall rules
setup_firewall() {
    echo "Setting up basic firewall rules..."

    # Flush existing rules
    iptables -F

    # Set default policies to drop
    iptables -P INPUT DROP
    iptables -P FORWARD DROP
    iptables -P OUTPUT ACCEPT

    # Allow loopback interface
    iptables -A INPUT -i lo -j ACCEPT
    iptables -A OUTPUT -o lo -j ACCEPT

    # Allow established and related connections
    iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

    # Allow SSH
    iptables -I INPUT -p tcp --dport 22 -j ACCEPT

    # Disallow HTTP and Allow HTTPS
    iptables -A INPUT -p tcp --dport 80 -j DROP
    iptables -A INPUT -p tcp --dport 443 -j ACCEPT

    echo "Basic firewall rules set up."
}

# Apply SSH restrictions
restrict_ssh() {
    echo "Applying SSH restrictions..."

    # Allow SSH from specific IP address
    iptables -I INPUT -p tcp -s 192.168.1.100 --dport 22 -j ACCEPT

    # Remove the general SSH rule
    iptables -D INPUT -p tcp --dport 22 -j ACCEPT

    echo "SSH restrictions applied."
}

# block unnecessary ports
block_ports() {
    echo "Blocking unnecessary ports..."

    # Block ports 23 (telnet), 25 (SMTP), 445 (SMB), 20/21 (FTP), 3306 (MYSQL)
    iptables -A INPUT -p tcp --dport 23 -j DROP
    iptables -A INPUT -p tcp --dport 25 -j DROP
    iptables -A INPUT -p tcp --dport 445 -j DROP
    iptables -A INPUT -p tcp --dport 3306 -j DROP
    iptables -A INPUT -p tcp --dport 21 -j DROP	
    echo "Unnecessary ports blocked."
}



# enable logging
enable_logging() {
    echo "Enabling firewall logging..."

    # Log dropped packets
    iptables -A INPUT -j LOG --log-prefix "iptables-dropped: " --log-level 4

    echo "Firewall logging enabled."
}
