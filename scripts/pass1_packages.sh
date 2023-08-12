#!/bin/bash

# For compiling m4
if [ -d $LFS/sources/compiling_area/m4 ]; then
	echo "M4 has already been compiled." |& tee $LFS/../log/$NOW/m4.log

else
	echo "compiling M4"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/m4

	tar -xf $LFS/sources/packages/m4-1.4.19.tar.xz -C $LFS/sources/compiling_area/m4

	pushd $LFS/sources/compiling_area/m4/m4-1.4.19
        ./configure --prefix=/usr \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess) |& tee $LFS/../log/$NOW/m4.log
        
        make |& tee -a $LFS/../log/$NOW/m4.log
        make DESTDIR=$LFS install |& tee -a $LFS/../log/$NOW/m4.log
	popd
fi


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
			../configure |& tee $LFS/../log/$NOW/ncurses.log
			make -C include |& tee -a $LFS/../log/$NOW/ncurses.log
			make -C progs tic |& tee -a $LFS/../log/$NOW/ncurses.log
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
			--enable-widec |& tee -a $LFS/../log/$NOW/ncurses.log


        make |& tee -a $LFS/../log/$NOW/ncurses.log
		make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install |& tee -a $LFS/../log/$NOW/ncurses.log
		echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so
	popd
fi

