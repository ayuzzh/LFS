#!/bin/bash

# For compiling Binutils-Pass2
if [ -d $LFS/sources/compiling_area/binutils-pass2 ]; then
	echo "Binutils-Pass2 has already been compiled."

else
	echo "compiling binutils-pass2"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/binutils-pass2

	tar -xf $LFS/sources/packages/binutils-2.40.tar.xz -C $LFS/sources/compiling_area/binutils-pass2

	pushd $LFS/sources/compiling_area/binutils-pass2/binutils-2.40
        sed '6009s/$add_dir//' -i ltmain.sh
        mkdir -v build
        pushd build
            ../configure                   \
                --prefix=/usr              \
                --build=$(../config.guess) \
                --host=$LFS_TGT            \
                --disable-nls              \
                --enable-shared            \
                --enable-gprofng=no        \
                --disable-werror           \
                --enable-64-bit-bfd
            make
            make DESTDIR=$LFS install
            rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.{a,la}
        popd
	popd
fi
