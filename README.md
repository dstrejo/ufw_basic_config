### Firewall and Security Policy Configuration Script

This script sets up basic firewall rules using `ufw` and applies security policies such as SSH restrictions, port blocking, and logging. There is also an interactive version with fewer options. 

- setup_firewall: Sets up basic firewall rules using ufw.
- restrict_ssh: Applies SSH restrictions to allow access only from specific IP addresses.
- block_ports: Blocks unnecessary ports to reduce the attack surface.
- enable_logging: Enables logging for firewall activity.
