#!/bin/bash

if [ -d $LFS/sources/compiling_area/libstdc++ ]; then
	echo "Libstdc++ has already been compiled."

else
	echo "compiling Libstdc++"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/libstdc++

	tar -xf $LFS/sources/packages/gcc-12.2.0.tar.xz -C $LFS/sources/compiling_area/libstdc++

	pushd $LFS/sources/compiling_area/libstdc++/gcc-12.2.0

        mkdir -p build
        pushd build

            ../libstdc++-v3/configure \
                --host=$LFS_TGT \
                --build=$(../config.guess) \
                --prefix=/usr \
                --disable-multilib \
                --disable-nls \
                --disable-libstdcxx-pch \
                --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/12.2.0

            make
            make DESTDIR=$LFS install

            rm -v $LFS/usr/lib/lib{stdc++,stdc++fs,supc++}.la
        popd

	popd
fi


