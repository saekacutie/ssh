#!/bin/bash

# --- UI COLORS ---
C='\033[1;36m'  # Cyan
P='\033[1;35m'  # Pink
G='\033[1;32m'  # Green
R='\033[1;31m'  # Red
B='\033[5m'     # Blink
W='\033[1;37m'  # White
OFF='\033[0m'

clear

# 1. THE GLOWING BANNER
echo -e "${C}${B}"
echo "  _____                _                             _  _    ___  _  _   "
echo " |  __ \              | |                           | || |  / _ \| || |  "
echo " | |__) |_ ____   _| |_ ___ _ __  _   _ _   _ _   _| || |_| | | | || |_ "
echo " |  ___/| '__\ \ / / __/ __| '_ \| | | | | | | | | |__   _| | | |__   _|"
echo " | |    | |   \ V /| |_\__ \ |_) | |_| | |_| | |_| |  | | | |_| |  | |  "
echo " |_|    |_|    \_/  \__|___/ .__/ \__, |\__, |\__, |  |_|  \___/   |_|  "
echo -e "${OFF}"
echo -e "${P}      >> PRVTSPYYY404 DEPLOYMENT SYSTEM << ${OFF}\n"

# 2. API & ACCOUNT CHECKS
echo -e "${C}> CHECKING APIS...${OFF}"
echo -e "${C}> ENABLING REQUIRED APIS...${OFF}"
gcloud services enable run.googleapis.com cloudbuild.googleapis.com --quiet > /dev/null 2>&1
echo -e "${C}> CHECKING ACCOUNT INFO...${OFF}"
sleep 1

echo -e "\n${R}${B}Locked to Region: US-CENTRAL1${OFF}"
read -p "$(echo -e ${G}"(Default: prvtspyyy) Enter Service Name: "${OFF})" SVC_NAME
SVC_NAME=${SVC_NAME:-prvtspyyy}

# 3. COMPILING LOGIC
echo -e "\n${P}>> STARTING CREATION PROCESS...${OFF}"

echo -en "${C}> INJECTING CORE PROTOCOLS... ${OFF}"
# Silence the build logs
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/$SVC_NAME . --quiet > /dev/null 2>&1
echo -e "${G}SUCCESS!${OFF}"

echo -en "${C}> DEPLOYING TO GOOGLE CLOUD... ${OFF}"
gcloud run deploy $SVC_NAME --image gcr.io/$GOOGLE_CLOUD_PROJECT/$SVC_NAME --region us-central1 --allow-unauthenticated --quiet > /dev/null 2>&1
echo -e "${G}SUCCESS!${OFF}"

# 4. FINAL SUCCESS SCREEN
clear
URL=$(gcloud run services describe $SVC_NAME --region us-central1 --format='value(status.url)')
echo -e "${G}====================================================${OFF}"
echo -e "${G}${B}       CREATION SSH ACCOUNT SUCCESSFUL!            ${OFF}"
echo -e "${G}====================================================${OFF}"
echo -e "${C}BANNER:    ${R}${B}Prvtspyyy404 Protocols${OFF}"
echo -e "${C}PROTOCOL:  ${W}SSH over WebSocket (TLS)${OFF}"
echo -e "${C}REGION:    ${W}US-CENTRAL1${OFF}"
echo -e "${C}SSH HOST:  ${G}${URL#https://}${OFF}"
echo -e "${C}SSH PORT:  ${G}443${OFF}"
echo -e "${C}SSH USER:  ${G}root${OFF}"
echo -e "${C}SSH PASS:  ${G}prvtspyyy${OFF}"
echo -e "${C}STATUS:    ${G}ACTIVE${OFF}"
echo -e "${G}====================================================${OFF}"
echo -e "${P}CONTACT Saeka Tojirp on Facebook for concerns${OFF}"
echo -e "${G}====================================================${OFF}"
