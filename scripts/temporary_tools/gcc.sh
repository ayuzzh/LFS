#!/bin/bash

# For compiling GCC-Pass2
if [ -d $LFS/sources/compiling_area/gcc-pass2 ]; then
	echo "GCC-Pass2 has already been compiled."

else
	echo "compiling gcc-pass2"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/gcc-pass2

	tar -xf $LFS/sources/packages/gcc-12.2.0.tar.xz -C $LFS/sources/compiling_area/gcc-pass2

	pushd $LFS/sources/compiling_area/gcc-pass2/gcc-12.2.0
        tar -xf $LFS/sources/packages/mpfr-4.2.0.tar.xz
        mv -v mpfr-4.2.0 mpfr
        tar -xf $LFS/sources/packages/gmp-6.2.1.tar.xz
        mv -v gmp-6.2.1 gmp
        tar -xf $LFS/sources/packages/mpc-1.3.1.tar.gz
        mv -v mpc-1.3.1 mpc

        sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
        sed '/thread_header =/s/@.*@/gthr-posix.h/' \
        -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in

        mkdir -pv build
        pushd build
            ../configure                                       \
                --build=$(../config.guess)                     \
                --host=$LFS_TGT                                \
                --target=$LFS_TGT                              \
                LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc      \
                --prefix=/usr                                  \
                --with-build-sysroot=$LFS                      \
                --enable-default-pie                           \
                --enable-default-ssp                           \
                --disable-nls                                  \
                --disable-multilib                             \
                --disable-libatomic                            \
                --disable-libgomp                              \
                --disable-libquadmath                          \
                --disable-libssp                               \
                --disable-libvtv                               \
                --enable-languages=c,c++
            make
            make DESTDIR=$LFS install
            ln -sv gcc $LFS/usr/bin/cc
        popd

	popd
fi
