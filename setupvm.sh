#!/bin/bash
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 6`
RESET=`tput sgr0`

sudo apt-get update
sudo apt-get upgrade -y
#Sets the clock of the VM
sudo hwclock --hctosys
#Edit hosts to redirect login.42.fr to my localhost

#===============================Installs===================================

#========GIT---------------
if ! [ -x "$(command -v git)" ]
then
    echo "${GREEN}Installing ${BLUE}git${RESET}"
    sudo apt install git -y
else
    echo "${BLUE}git${RED} already Installed${RESET}"
fi
#========VIM---------------

if ! [ -x "$(command -v vim)" ]
then
    echo "${GREEN}Installing ${BLUE}vim${RESET}"
    sudo apt install vim -y
else
    echo "${BLUE}vim${RED} already Installed${RESET}"
fi

#-------CURL---------------
if ! [ -x "$(command -v curl)" ]
then
    echo "${GREEN}Installing ${BLUE}curl${RED}, ${BLUE}ca-certificates${RED} and ${BLUE}gnupg${RESET}"
    sudo apt-get install ca-certificates curl gnupg lsb-release -y
else
    echo "${BLUE}curl${RED} already Installed${RESET}"
fi

if ! [ -x "$(command -v lsb_release)" ]
then
    echo "${GREEN}Installing ${BLUE}lsb-release${RESET}"
    sudo apt-get install lsb-release -y
else
    echo "${BLUE}lsb_release${RED} already Installed${RESET}"
fi

#-------DOCKER---------------
if ! [ -x "$(command -v docker)" ]
then
    echo "${GREEN}Adding ${BLUE}Docker${GREEN}’s official ${BLUE}GPG key${RESET}"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "${GREEN}setting up the stable repository${RESET}"
    echo   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    echo "${GREEN}Re-update The System${RESET}"
    sudo apt-get update -y
    echo "${GREEN}Installing ${BLUE}docker${RESET}"
    sudo apt-get install docker-ce docker-ce-cli containerd.io -y
else
      echo "${BLUE}docker${RED} already Installed${RESET}"
fi

#-------DOCKER without sudo---------------
echo "${GREEN}Make docker run as${BLUE} root${RESET}"
if grep -q docker /etc/group
  then
    echo "${GREEN}The Group${BLUE} docker${GREEN} Exists${RESET}"
else
    sudo groupadd docker
fi
sudo usermod -aG docker $USER
sudo service docker restart

#-------DOCKERCOMPOSE---------------
if ! [ -x "$(command -v docker-compose)" ]
  then
    echo "${GREEN}Downloading the current stable release of Docker Compose${RESET}"
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    echo "${GREEN}Apply executable permissions to the binary${RESET}"
    sudo chmod +x /usr/local/bin/docker-compose
else
    echo "${BLUE}docker-compose${RED} already Installed${RESET}"
fi

sudo sed -i "s/localhost/ypetruzz.42.fr/g" /etc/hosts

echo -e "${RED}╔════════════════════════════║NOTE:║════════════════════════╗${RESET}"
echo -e "${RED}║   ${BLUE} Please Restart Your machine To apply Those changes!${RED}    ║${RESET}"
echo -e "${RED}╚═══════════════════════════════════════════════════════════╝${RESET}"
