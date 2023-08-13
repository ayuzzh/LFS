#!/bin/bash

# For compiling findutils
if [ -d $LFS/sources/compiling_area/findutils ]; then
	echo "findutils has already been compiled."

else
	echo "compiling findutils"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/findutils

	tar -xf $LFS/sources/packages/findutils-4.9.0.tar.xz -C $LFS/sources/compiling_area/findutils

	pushd $LFS/sources/compiling_area/findutils/findutils-4.9.0
        ./configure --prefix=/usr                   \
            --localstatedir=/var/lib/locate \
            --host=$LFS_TGT                 \
            --build=$(build-aux/config.guess)
        
        make
        make DESTDIR=$LFS install
	popd
fi
