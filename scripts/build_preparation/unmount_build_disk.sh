
#######################################
#### Unmounting the Build Drive #######
#######################################

echo "The Build is completed."
echo "Unmounting the Build Drive"

sudo umount /dev/loop20
sudo umount /dev/loop21

sudo losetup -d /dev/loop20
sudo losetup -d /dev/loop21

#######################################

