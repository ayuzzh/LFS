
sudo chown -v $USER $LFS

#######################################
#### Setting Up the Build Drive #######
#######################################

mkdir -pv $LFS/sources
mkdir -pv $LFS/tools

mkdir -pv $LFS/boot
mkdir -pv $LFS/etc
mkdir -pv $LFS/usr
mkdir -pv $LFS/var
mkdir -pv $LFS/lib64

mkdir -pv $LFS/usr/{bin,lib,sbin}

for i in bin sbin lib; do
	sudo ln -sfv usr/$i $LFS/$i
done


mkdir -pv $LFS/sources/packages
mkdir -pv $LFS/sources/patches
mkdir -pv $LFS/sources/compiling_area
#######################################

