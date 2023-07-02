#!/bin/bash

clear

show_main_menu() {
while true; do
clear
echo "#################################################################"
echo "script-xanmod-unofficial-installer: july 2023"
echo "#################################################################"
echo " ██   ██ ███████ ██████  ███    ██ ███████ ██     " 
echo " ██  ██  ██      ██   ██ ████   ██ ██      ██     " 
echo " █████   █████   ██████  ██ ██  ██ █████   ██     " 
echo " ██  ██  ██      ██   ██ ██  ██ ██ ██      ██     " 
echo " ██   ██ ███████ ██   ██ ██   ████ ███████ ███████"                                                                                                                                                        
echo "#################################################################"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
echo "build-latest: 0.0.1"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
echo "script-xanmod-installer-unofficial-github: https://github.com/manoel-linux/script-xanmod-installer-unofficial"
echo "#################################################################"


if [[ $EUID -ne 0 ]]; then
echo " ███████ ██████  ██████   ██████  ██████  ██ "
echo " ██      ██   ██ ██   ██ ██    ██ ██   ██ ██ "
echo " █████   ██████  ██████  ██    ██ ██████  ██ "
echo " ██      ██   ██ ██   ██ ██    ██ ██   ██    "
echo " ███████ ██   ██ ██   ██  ██████  ██   ██ ██ "                                                                                        
echo "#################################################################"
echo "Superuser privileges or sudo required to execute the script." 
echo "#################################################################"
exit 1
fi

web="fsf.org"

if ! ping -q -c 1 -W 1 "$web" >/dev/null; then
echo "#################################################################"
echo "No internet connection. The script will not be executed."
echo "#################################################################"
exit 1
fi

sudo apt-get install --no-install-recommends inetutils-ping -y
echo "#################################################################"

clear

echo "#################################################################"
echo "Connected to the internet. Running the script..."
echo "#################################################################"
echo "(1)> (Install) the linux-xanmod-x64v1 all-x86-64-CPUs"
echo "(2)> (Install) the linux-xanmod-lts-x64v1 all-x86-64-CPUs"
echo "(3)> (Exit)"
echo "#################################################################"

read -p "Enter your choice: " choice
echo "#################################################################"

case $choice in
1)
show_linux_xanmod_v1
;;
2)
show_linux_xanmod_lts_x64v1
;;
3)
exit 0
;;
*)
echo "Invalid choice. Please try again."
echo "#################################################################"
sleep 2
;;
esac
done
}

show_linux_xanmod_v1() {
while true; do
clear
if [ ! -x /bin/apt ]; then
echo "#################################################################"
echo "(Warning!) >> You are trying to execute a script specifically designed for Ubuntu/Debian."
echo "#################################################################"
exit 1
fi
echo "#################################################################"
read -p "This action may have unintended consequences. Are you sure you want to continue? (y/n): " second_confirm
echo "#################################################################"
if [[ "$second_confirm" == "y" || "$second_confirm" == "Y" ]]; then
read -p "WARNING: This script is provided 'AS IS', without any warranties of any kind. The user assumes full responsibility for executing this script and any resulting consequences. We recommend backing up your data before proceeding. If the script does not cause any apparent issues, you can use the PC normally. Are you sure you want to proceed? (y/n): " third_confirm
echo "#################################################################"
if [[ "$third_confirm" == "y" || "$third_confirm" == "Y" ]]; then
echo "Proceeding with the changes..."
else
echo "Action canceled by the user."
echo "#################################################################"
exit 1
fi
else
echo "Action canceled by the user."
echo "#################################################################"
exit 1
fi
echo "#################################################################"
echo "Checking for updates in Ubuntu/Debian..." 
echo "#################################################################"
sudo apt-get install --no-install-recommends gpg unzip binutils tar curl xz-utils grep gawk sed -y
clear
echo "#################################################################"

read -p "Do you want to update your system? (y/n): " choice
echo "#################################################################"
if [[ $choice == "y" || $choice == "Y" ]]; then
curl -fSsL https://dl.xanmod.org/archive.key | gpg --dearmor | sudo tee /usr/share/keyrings/xanmod-archive-keyring.gpg > /dev/null
echo 'deb [signed-by=/usr/share/keyrings/xanmod-archive-keyring.gpg] http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-release.list
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install --no-install-recommends linux-xanmod-x64v1 -y
else
echo "Skipping system update."
echo "#################################################################"
curl -fSsL https://dl.xanmod.org/archive.key | gpg --dearmor | sudo tee /usr/share/keyrings/xanmod-archive-keyring.gpg > /dev/null
echo 'deb [signed-by=/usr/share/keyrings/xanmod-archive-keyring.gpg] http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-release.list
sudo apt-get update
sudo apt-get install --no-install-recommends linux-xanmod-x64v1 -y
fi

echo "#################################################################"
read -p "(Warning!) >> I am not responsible for any damages. Proceed at your own risk. 
You want to remove all kernels and leave only Xanmod? (y/n): " choice
echo "#################################################################"
if [[ $choice == "y" || $choice == "Y" ]]; then
sudo dpkg --list | grep linux-image | awk '/linux-image-[^x]/{print $2}' | grep -v -e xanmod | xargs sudo apt-get purge -y
sudo apt-get autoremove -y 
sudo apt-get autoclean -y
sudo dpkg --list | grep linux-image-generic | awk '/linux-image-[^x]/{print $2}' | grep -v -e xanmod | xargs sudo apt-get purge -y
sudo apt-get autoremove -y 
sudo apt-get autoclean -y
else
echo "Skipping."
echo "#################################################################"
fi

clear

echo "#################################################################"
echo " ██████   ██████  ███    ██ ███████ ██ "
echo " ██   ██ ██    ██ ████   ██ ██      ██ "
echo " ██   ██ ██    ██ ██ ██  ██ █████   ██ "
echo " ██   ██ ██    ██ ██  ██ ██ ██         "
echo " ██████   ██████  ██   ████ ███████ ██ "  
echo "#################################################################"
echo "Xanmod successfully installed"
echo "#################################################################"
echo "To update Xanmod, use the following command: sudo apt-get update && sudo apt-get upgrade"
echo "#################################################################"  
read -p "To apply the changes, you need to restart system. (y/n): " confirm
                
if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
echo "#################################################################"
echo "Restarting the system..."    
echo "#################################################################"
sudo reboot
else
echo "#################################################################"
echo "Restart canceled."
echo "#################################################################"
fi
read -rsn1 -p "press Enter to return to the main menu
#################################################################" key
if [[ $key == "r" || $key == "R" ]]; then
continue
fi

break
done

echo "#################################################################"
}

show_linux_xanmod_lts_x64v1() {
while true; do
clear
if [ ! -x /bin/apt ]; then
echo "#################################################################"
echo "(Warning!) >> You are trying to run a version meant for another distribution. 
To prevent issues, the script has blocked a warning to execute the version meant for your distribution."
echo "#################################################################"
exit 1
fi
echo "#################################################################"
read -p "This action may have unintended consequences. Are you sure you want to continue? (y/n): " second_confirm
echo "#################################################################"
if [[ "$second_confirm" == "y" || "$second_confirm" == "Y" ]]; then
read -p "WARNING: This script is provided 'AS IS', without any warranties of any kind. The user assumes full responsibility for executing this script and any resulting consequences. We recommend backing up your data before proceeding. If the script does not cause any apparent issues, you can use the PC normally. Are you sure you want to proceed? (y/n): " third_confirm
echo "#################################################################"
if [[ "$third_confirm" == "y" || "$third_confirm" == "Y" ]]; then
echo "Proceeding with the changes..."
else
echo "Action canceled by the user."
echo "#################################################################"
exit 1
fi
else
echo "Action canceled by the user."
echo "#################################################################"
exit 1
fi
echo "#################################################################"
echo "Checking for updates in Ubuntu/Debian..." 
echo "#################################################################"
sudo apt-get install --no-install-recommends gpg unzip binutils tar curl xz-utils grep gawk sed -y
clear
echo "#################################################################"

read -p "Do you want to update your system? (y/n): " choice
echo "#################################################################"
if [[ $choice == "y" || $choice == "Y" ]]; then
curl -fSsL https://dl.xanmod.org/archive.key | gpg --dearmor | sudo tee /usr/share/keyrings/xanmod-archive-keyring.gpg > /dev/null
echo 'deb [signed-by=/usr/share/keyrings/xanmod-archive-keyring.gpg] http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-release.list
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install --no-install-recommends linux-xanmod-lts-x64v1 -y
else
echo "Skipping system update."
echo "#################################################################"
curl -fSsL https://dl.xanmod.org/archive.key | gpg --dearmor | sudo tee /usr/share/keyrings/xanmod-archive-keyring.gpg > /dev/null
echo 'deb [signed-by=/usr/share/keyrings/xanmod-archive-keyring.gpg] http://deb.xanmod.org releases main' | sudo tee /etc/apt/sources.list.d/xanmod-release.list
sudo apt-get update
sudo apt-get install --no-install-recommends linux-xanmod-lts-x64v1 -y
fi

echo "#################################################################"
read -p "(Warning!) >> I am not responsible for any damages. Proceed at your own risk. 
You want to remove all kernels and leave only Xanmod? (y/n): " choice
echo "#################################################################"
if [[ $choice == "y" || $choice == "Y" ]]; then
sudo dpkg --list | grep linux-image | awk '/linux-image-[^x]/{print $2}' | grep -v -e xanmod | xargs sudo apt-get purge -y
sudo apt-get autoremove -y 
sudo apt-get autoclean -y
sudo dpkg --list | grep linux-image-generic | awk '/linux-image-[^x]/{print $2}' | grep -v -e xanmod | xargs sudo apt-get purge -y
sudo apt-get autoremove -y 
sudo apt-get autoclean -y
else
echo "Skipping."
echo "#################################################################"
fi

clear

echo "#################################################################"
echo " ██████   ██████  ███    ██ ███████ ██ "
echo " ██   ██ ██    ██ ████   ██ ██      ██ "
echo " ██   ██ ██    ██ ██ ██  ██ █████   ██ "
echo " ██   ██ ██    ██ ██  ██ ██ ██         "
echo " ██████   ██████  ██   ████ ███████ ██ "  
echo "#################################################################"
echo "Xanmod successfully installed"
echo "#################################################################"
echo "To update Xanmod, use the following command: sudo apt-get update && sudo apt-get upgrade"
echo "#################################################################"  
read -p "To apply the changes, you need to restart system. (y/n): " confirm
                
if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
echo "#################################################################"
echo "Restarting the system..."    
echo "#################################################################"
sudo reboot
else
echo "#################################################################"
echo "Restart canceled."
echo "#################################################################"
fi
read -rsn1 -p "press Enter to return to the main menu
#################################################################" key
if [[ $key == "r" || $key == "R" ]]; then
continue
fi

break
done

echo "#################################################################"
}

show_main_menu
