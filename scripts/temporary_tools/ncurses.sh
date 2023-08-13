#!/bin/bash

# For compiling ncurses
if [ -d $LFS/sources/compiling_area/ncurses ]; then
	echo "ncurses has already been compiled." |& tee $LFS/../log/$NOW/ncurses.log

else
	echo "compiling ncurses"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/ncurses

	tar -xf $LFS/sources/packages/ncurses-6.4.tar.gz -C $LFS/sources/compiling_area/ncurses

	pushd $LFS/sources/compiling_area/ncurses/ncurses-6.4

        mkdir build
		pushd build
			../configure
			make -C include
			make -C progs tic
		popd

		./configure --prefix=/usr \
			--host=$LFS_TGT \
			--build=$(./config.guess) \
			--mandir=/usr/share/man \
			--with-manpage-format=normal \
			--with-shared \
			--without-normal \
			--with-cxx-shared \
			--without-debug \
			--without-ada \
			--disable-stripping \
			--enable-widec

        make
		make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
		echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so
	popd
fi

