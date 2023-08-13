#!/bin/bash

# For compiling tar
if [ -d $LFS/sources/compiling_area/tar ]; then
	echo "tar has already been compiled."

else
	echo "compiling tar"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/tar

	tar -xf $LFS/sources/packages/tar-1.34.tar.xz -C $LFS/sources/compiling_area/tar

	pushd $LFS/sources/compiling_area/tar/tar-1.34
        ./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess)
        
        make
        make DESTDIR=$LFS install
	popd
fi
