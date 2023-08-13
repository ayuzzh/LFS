#!/bin/bash

# For compiling bash
if [ -d $LFS/sources/compiling_area/bash ]; then
	echo "Bash has already been compiled."

else
	echo "compiling BASH"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/bash

	tar -xf $LFS/sources/packages/bash-5.2.15.tar.gz -C $LFS/sources/compiling_area/bash

	pushd $LFS/sources/compiling_area/bash/bash-5.2.15
        ./configure --prefix=/usr \
            --build=$(sh support/config.guess) \
            --host=$LFS_TGT \
            --without-bash-malloc
        
        make
        make DESTDIR=$LFS install
        ln -sfv bash $LFS/bin/sh
	popd
fi
