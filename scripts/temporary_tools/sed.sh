#!/bin/bash

# For compiling sed
if [ -d $LFS/sources/compiling_area/sed ]; then
	echo "sed has already been compiled."

else
	echo "compiling sed"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/sed

	tar -xf $LFS/sources/packages/sed-4.9.tar.xz -C $LFS/sources/compiling_area/sed

	pushd $LFS/sources/compiling_area/sed/sed-4.9
        ./configure --prefix=/usr --host=$LFS_TGT
        
        make
        make DESTDIR=$LFS install
	popd
fi
