#!/bin/bash

# For compiling bash
if [ -d $LFS/sources/compiling_area/gawk ]; then
	echo "gawk has already been compiled."

else
	echo "compiling gawk"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/gawk

	tar -xf $LFS/sources/packages/gawk-5.2.1.tar.xz -C $LFS/sources/compiling_area/gawk

	pushd $LFS/sources/compiling_area/gawk/gawk-5.2.1
        sed -i 's/extras//' Makefile.in
        ./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
        make
        make DESTDIR=$LFS install
	popd
fi
