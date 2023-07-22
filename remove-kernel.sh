#!/bin/bash

clear

show_main_menu() {
while true; do
clear
echo "#################################################################"
echo " ██   ██ ███████ ██████  ███    ██ ███████ ██     " 
echo " ██  ██  ██      ██   ██ ████   ██ ██      ██     " 
echo " █████   █████   ██████  ██ ██  ██ █████   ██     " 
echo " ██  ██  ██      ██   ██ ██  ██ ██ ██      ██     " 
echo " ██   ██ ███████ ██   ██ ██   ████ ███████ ███████"                                                                                                                                                        
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
echo "(1)> (Remove) all kernels and keep only the Xanmod."
echo "(2)> (Exit)"
echo "#################################################################"

read -p "Enter your choice: " choice
echo "#################################################################"

case $choice in
1)
show_linux_kernel
;;
2)
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

show_linux_kernel() {
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
sudo apt-get update -y
sudo apt-get upgrade -y
else
echo "Skipping system update."
echo "#################################################################"
sudo apt-get update
fi

echo "#################################################################"
sudo dpkg --list | grep linux-image | awk '/linux-image-[^x]/{print $2}' | grep -v -e xanmod | xargs sudo apt-get purge -y
sudo apt-get autoremove -y 
sudo apt-get autoclean -y
sudo dpkg --list | grep linux-image-generic | awk '/linux-image-[^x]/{print $2}' | grep -v -e xanmod | xargs sudo apt-get purge -y
sudo apt-get autoremove -y 
sudo apt-get autoclean -y

clear

echo "#################################################################"
echo " ██████   ██████  ███    ██ ███████ ██ "
echo " ██   ██ ██    ██ ████   ██ ██      ██ "
echo " ██   ██ ██    ██ ██ ██  ██ █████   ██ "
echo " ██   ██ ██    ██ ██  ██ ██ ██         "
echo " ██████   ██████  ██   ████ ███████ ██ "  
echo "#################################################################"
echo "Successful uninstallation of all kernels except Xanmod"
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
