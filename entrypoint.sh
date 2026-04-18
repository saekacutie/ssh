#!/bin/bash
# GCP Port handling
L_PORT=${PORT:-8080}

# 1. Configure SSH
sed -i "s/#Port 22/Port 2222/g" /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# 2. Create the RED GLOWING SSH MOTD
# This shows when the user successfully connects via VPN
echo -e "\n\033[1;31m\033[5m Prvtspyyy404 Protocols \033[0m\n" > /etc/motd

# 3. Start SSH Daemon
/usr/sbin/sshd

# 4. Start the Web Dashboard in the background
python3 app.py &

# 5. Start the Websocket Bridge (Tunnel)
# We use port 8081 internally for the tunnel, or share the main port
exec websockify 0.0.0.0:8081 127.0.0.1:2222 --heartbeat 30
