#!/bin/bash

if [ -d $LFS/sources/compiling_area/gcc ]; then
	echo "GCC has already been compiled."

else
	echo "compiling GCC"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/gcc

	tar -xf $LFS/sources/packages/gcc-12.2.0.tar.xz -C $LFS/sources/compiling_area/gcc

	pushd $LFS/sources/compiling_area/gcc/gcc-12.2.0

		tar -xf $LFS/sources/packages/mpfr-4.2.0.tar.xz
		tar -xf $LFS/sources/packages/gmp-6.2.1.tar.xz
		tar -xf $LFS/sources/packages/mpc-1.3.1.tar.gz

		mv -f mpfr-4.2.0 mpfr
		mv -f gmp-6.2.1 gmp
		mv -f mpc-1.3.1 mpc

		case $(uname -m) in x86_64)
			sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64;;
		esac

		mkdir -pv build
		pushd build
			../configure --target=$LFS_TGT \
				--prefix=$LFS/tools \
				--with-glibc-version=2.37 \
				--with-sysroot=$LFS \
				--with-newlib \
				--without-headers \
				--enable-default-pie \
				--enable-default-ssp \
				--disable-nls \
				--disable-shared \
				--disable-multilib \
				--disable-threads \
				--disable-libatomic \
				--disable-libgomp \
				--disable-libquadmath \
				--disable-libssp \
				--disable-libvtv \
				--disable-libstdcxx \
				--enable-languages=c,c++

			make
			make install
		popd
		cat gcc/limitx.h gcc/glimits.h gcc/limity.h > `dirname $($LFS/tools/bin/$LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h
	popd
fi
