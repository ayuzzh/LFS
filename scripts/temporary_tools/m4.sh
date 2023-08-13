#!/bin/bash

# For compiling m4
if [ -d $LFS/sources/compiling_area/m4 ]; then
	echo "M4 has already been compiled."

else
	echo "compiling M4"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/m4

	tar -xf $LFS/sources/packages/m4-1.4.19.tar.xz -C $LFS/sources/compiling_area/m4

	pushd $LFS/sources/compiling_area/m4/m4-1.4.19
        ./configure --prefix=/usr \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
        
        make
        make DESTDIR=$LFS install
	popd
fi
