#!/bin/bash

if [ -d $LFS/sources/compiling_area/glibc ]; then
	echo "Glibc has already been compiled."

else
	echo "compiling Glibc"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/glibc

	tar -xf $LFS/sources/packages/glibc-2.37.tar.xz -C $LFS/sources/compiling_area/glibc

	pushd $LFS/sources/compiling_area/glibc/glibc-2.37

		ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
		ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3



		patch -Np1 -i $LFS/sources/patches/glibc-2.37-fhs-1.patch

		mkdir -v build
		pushd build
			echo "rootsbindir=/usr/sbin" > configparms

			../configure \
				--prefix=/usr \
				--host=$LFS_TGT \
				--build=$(../scripts/config.guess) \
				--enable-kernel=3.2 \
				--with-headers=$LFS/usr/include \
				libc_cv_slibdir=/usr/lib

			make
			make DESTDIR=$LFS install

			sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd
			$LFS/tools/libexec/gcc/$LFS_TGT/12.2.0/install-tools/mkheaders
		popd

	popd
fi
