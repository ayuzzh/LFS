#!/bin/bash

FORMAT_DISK () {
	yes | sudo mkfs -t ext4 /dev/loop20
	yes | sudo mkfs -t ext4 /dev/loop21
}

#######################################
#### Setting Up the Build Drive #######
#######################################

sudo losetup /dev/loop20 $LFS/../os_boot.loop
sudo losetup /dev/loop21 $LFS/../os_root.loop

while true; do
	read -p "Do you want to formate the Build Drive?" yn
	case $yn in
		[Yy]* ) echo "Formating the Build Drive" && FORMAT_DISK && break;;
		[Nn]* ) echo "Proceeding without formatting" && break;;
		* ) echo "Please answer yes or no.";;
	esac
done

sudo mount /dev/loop21 $LFS

#######################################

