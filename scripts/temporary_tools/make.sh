#!/bin/bash

# For compiling make
if [ -d $LFS/sources/compiling_area/make ]; then
	echo "make has already been compiled."

else
	echo "compiling make"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/make

	tar -xf $LFS/sources/packages/make-4.4.tar.gz -C $LFS/sources/compiling_area/make

	pushd $LFS/sources/compiling_area/make/make-4.4
        sed -e '/ifdef SIGPIPE/,+2 d' \
            -e '/undef  FATAL_SIG/i FATAL_SIG (SIGPIPE);' \
            -i src/main.c
        ./configure --prefix=/usr   \
            --without-guile \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
        
        make
        make DESTDIR=$LFS install
	popd
fi
