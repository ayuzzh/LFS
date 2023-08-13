#!/bin/bash

# For compiling gzip
if [ -d $LFS/sources/compiling_area/gzip ]; then
	echo "gzip has already been compiled."

else
	echo "compiling gzip"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/gzip

	tar -xf $LFS/sources/packages/gzip-1.12.tar.xz -C $LFS/sources/compiling_area/gzip

	pushd $LFS/sources/compiling_area/gzip/gzip-1.12
        ./configure --prefix=/usr --host=$LFS_TGT        
        make
        make DESTDIR=$LFS install
	popd
fi
