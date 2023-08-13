#!/bin/bash

# For compiling bash
if [ -d $LFS/sources/compiling_area/coreutils ]; then
	echo "Coreutils has already been compiled."

else
	echo "compiling Coreutils"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/coreutils

	tar -xf $LFS/sources/packages/coreutils-9.1.tar.xz -C $LFS/sources/compiling_area/coreutils

	pushd $LFS/sources/compiling_area/coreutils/coreutils-9.1
        ./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --enable-install-program=hostname \
            --enable-no-install-program=kill,uptime
        
        make
        make DESTDIR=$LFS install
        
        mv -v $LFS/usr/bin/chroot $LFS/usr/sbin
        mkdir -pv $LFS/usr/share/man/man8
        mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
        sed -i 's/"1"/"8"/' $LFS/usr/share/man/man8/chroot.8
	popd
fi
