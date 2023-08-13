#!/bin/bash

# For compiling grep
if [ -d $LFS/sources/compiling_area/grep ]; then
	echo "grep has already been compiled."

else
	echo "compiling grep"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/grep

	tar -xf $LFS/sources/packages/grep-3.8.tar.xz -C $LFS/sources/compiling_area/grep

	pushd $LFS/sources/compiling_area/grep/grep-3.8
        ./configure --prefix=/usr --host=$LFS_TGT
        
        make
        make DESTDIR=$LFS install
	popd
fi
