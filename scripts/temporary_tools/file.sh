#!/bin/bash

# For compiling File
if [ -d $LFS/sources/compiling_area/file ]; then
	echo "File has already been compiled."

else
	echo "compiling File"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/file

	tar -xf $LFS/sources/packages/file-5.44.tar.gz -C $LFS/sources/compiling_area/file

	pushd $LFS/sources/compiling_area/file/file-5.44
                mkdir build
                pushd build
                        ../configure --disable-bzlib      \
                                --disable-libseccomp \
                                  --disable-xzlib      \
                                  --disable-zlib
                        make
                popd

                ./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)
                make FILE_COMPILE=$(pwd)/build/src/file
                make DESTDIR=$LFS install
                rm -v $LFS/usr/lib/libmagic.la
	popd
fi
