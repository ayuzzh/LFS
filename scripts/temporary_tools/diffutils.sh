#!/bin/bash

# For compiling diffutils
if [ -d $LFS/sources/compiling_area/diffutils ]; then
	echo "Diffutils has already been compiled."

else
	echo "compiling Diffutils"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/diffutils

	tar -xf $LFS/sources/packages/diffutils-3.9.tar.xz -C $LFS/sources/compiling_area/diffutils

	pushd $LFS/sources/compiling_area/diffutils/diffutils-3.9
        ./configure --prefix=/usr --host=$LFS_TGT
        
        make
        make DESTDIR=$LFS install
	popd
fi
