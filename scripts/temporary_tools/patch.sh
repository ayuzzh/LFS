#!/bin/bash

# For compiling patch
if [ -d $LFS/sources/compiling_area/patch ]; then
	echo "patch has already been compiled."

else
	echo "compiling patch"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/patch

	tar -xf $LFS/sources/packages/patch-2.7.6.tar.xz -C $LFS/sources/compiling_area/patch

	pushd $LFS/sources/compiling_area/patch/patch-2.7.6
        ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
        
        make
        make DESTDIR=$LFS install
	popd
fi
