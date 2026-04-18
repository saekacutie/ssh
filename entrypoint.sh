#!/bin/bash
# Internal Port Handling
L_PORT=${PORT:-8080}

# Configure SSH
sed -i "s/#Port 22/Port 2222/g" /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# RED GLOWING SSH MESSAGE
echo -e "\n\033[1;31m\033[5m Prvtspyyy404 Protocols \033[0m\n" > /etc/motd

# Start Daemons
/usr/sbin/sshd
python3 app.py &

# Start WebSocket Bridge
exec websockify 0.0.0.0:8081 127.0.0.1:2222 --heartbeat 30
