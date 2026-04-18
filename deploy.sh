#!/bin/bash

# --- ADVANCED UI COLORS ---
C='\033[1;36m'   # CYAN
P='\033[1;35m'   # PINK
G='\033[1;32m'   # GREEN
R='\033[1;31m'   # RED
W='\033[1;37m'   # WHITE
B='\033[5m'      # BLINK
BOLD='\033[1m'
OFF='\033[0m'

clear

# --- 1. IMPROVED 3D BANNER ---
echo -e "${C}${BOLD}"
echo "  ██████╗ ██████╗ ██╗   ██╗████████╗███████╗██████╗ ██╗   ██╗██╗   ██╗██╗   ██╗"
echo "  ██╔══██╗██╔══██╗██║   ██║╚══██╔══╝██╔════╝██╔══██╗╚██╗ ██╔╝╚██╗ ██╔╝╚██╗ ██╔╝"
echo "  ██████╔╝██████╔╝██║   ██║   ██║   ███████╗██████╔╝ ╚████╔╝  ╚████╔╝  ╚████╔╝ "
echo "  ██╔═══╝ ██╔══██╗╚██╗ ██╔╝   ██║   ╚════██║██╔═══╝   ╚██╔╝    ╚██╔╝    ╚██╔╝  "
echo "  ██║     ██║  ██║ ╚████╔╝    ██║   ███████║██║        ██║      ██║      ██║   "
echo "  ╚═╝     ╚═╝  ╚═╝  ╚═══╝     ╚═╝   ╚══════╝╚═╝        ╚═╝      ╚═╝      ╚═╝   "
echo -e "${P}${BOLD}                     [ made by Saeka Torjip - SSH ] ${OFF}\n"

# --- 2. INITIALIZATION UI ---
echo -e "${W}${BOLD}┌──────────────────────────────────────────────────────────┐${OFF}"
echo -e "${W}${BOLD}│${OFF} ${C}${BOLD}SYSTEM STATUS:${OFF}  ${G}${BOLD}READY${OFF}                                ${W}${BOLD}│${OFF}"
echo -e "${W}${BOLD}│${OFF} ${C}${BOLD}REGION:${OFF}         ${R}${BOLD}US-CENTRAL1 (LOCKED)${OFF}               ${W}${BOLD}│${OFF}"
echo -e "${W}${BOLD}└──────────────────────────────────────────────────────────┘${OFF}\n"

echo -e "${C}${BOLD}> ENABLING:${OFF} ${W}Google Cloud Run API...${OFF}"
gcloud services enable run.googleapis.com --quiet > /dev/null 2>&1
echo -e "${C}${BOLD}> ENABLING:${OFF} ${W}Google Cloud Build API...${OFF}"
gcloud services enable cloudbuild.googleapis.com --quiet > /dev/null 2>&1
echo -e "${C}${BOLD}> CHECKING:${OFF} ${W}Identity & Access Management...${OFF}"
sleep 1

echo -en "\n${P}${BOLD}SERVICE NAME (Default: prvtspyyy): ${OFF}"
read SVC_NAME
SVC_NAME=${SVC_NAME:-prvtspyyy}

# --- 3. DEPLOYMENT ENGINE ---
echo -e "\n${C}${BOLD}┌─${OFF} ${P}${BOLD}DEPLOYMENT IN PROGRESS${OFF} ${C}${BOLD}─────────────────────────────┐${OFF}"

echo -en "${C}${BOLD}│${OFF} ${W}COMPILING PROJECT...       ${OFF}"
gcloud builds submit --tag gcr.io/$GOOGLE_CLOUD_PROJECT/$SVC_NAME . --quiet > /dev/null 2>&1
echo -e "${G}${BOLD}[DONE]${OFF} ${C}${BOLD}│${OFF}"

echo -en "${C}${BOLD}│${OFF} ${W}INJECTING TO CLOUD RUN...  ${OFF}"
gcloud run deploy $SVC_NAME --image gcr.io/$GOOGLE_CLOUD_PROJECT/$SVC_NAME --region us-central1 --allow-unauthenticated --quiet > /dev/null 2>&1
echo -e "${G}${BOLD}[DONE]${OFF} ${C}${BOLD}│${OFF}"
echo -e "${C}${BOLD}└──────────────────────────────────────────────────────────┘${OFF}"

# --- 4. EXTRACTING REAL run.app URL ---
# This fixes the missing URL problem
URL=$(gcloud run services describe $SVC_NAME --region us-central1 --format='value(status.url)')
HOST=${URL#https://}

# --- 5. FINAL 3D SUCCESS BANNER ---
clear
echo -e "${G}${BOLD}████████████████████████████████████████████████████████████${OFF}"
echo -e "${G}${BOLD}█${OFF}                                                          ${G}${BOLD}█${OFF}"
echo -e "${G}${BOLD}█${OFF}    ${G}${B}${BOLD}CREATION SSH ACCOUNT SUCCESSFUL!${OFF}                      ${G}${BOLD}█${OFF}"
echo -e "${G}${BOLD}█${OFF}                                                          ${G}${BOLD}█${OFF}"
echo -e "${G}${BOLD}████████████████████████████████████████████████████████████${OFF}"
echo -e "${W}${BOLD}│${OFF}"
echo -e "${W}${BOLD}├── ${C}${BOLD}HOST:      ${W}${BOLD}${HOST}${OFF}"
echo -e "${W}${BOLD}├── ${C}${BOLD}PORT:      ${G}${BOLD}443${OFF}"
echo -e "${W}${BOLD}├── ${C}${BOLD}USER:      ${G}${BOLD}root${OFF}"
echo -e "${W}${BOLD}├── ${C}${BOLD}PASS:      ${G}${BOLD}prvtspyyy${OFF}"
echo -e "${W}${BOLD}├── ${C}${BOLD}PROTO:     ${P}${BOLD}SSH Over WebSocket (TLS)${OFF}"
echo -e "${W}${BOLD}└── ${C}${BOLD}REGION:    ${W}${BOLD}US-CENTRAL1${OFF}"
echo -e "${G}${BOLD}============================================================${OFF}"
echo -e "${P}${BOLD}  CONTACT SAEKA TOJIRP ON FACEBOOK FOR CONCERNS & COMPLAINS ${OFF}"
echo -e "${G}${BOLD}============================================================${OFF}"
