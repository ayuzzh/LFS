#!/bin/bash

if [ -d $LFS/sources/compiling_area/linux_api_headers ]; then
	echo "Linux API Headers has already been compiled."

else
	echo "compiling Linux Api Headers"
	sleep 5
	mkdir -pv $LFS/sources/compiling_area/linux_api_headers

	tar -xf $LFS/sources/packages/linux-6.1.11.tar.xz -C $LFS/sources/compiling_area/linux_api_headers

	pushd $LFS/sources/compiling_area/linux_api_headers/linux-6.1.11

		make mrproper

		make headers
		find usr/include -type f ! -name '*.h' -delete
		cp -rv usr/include $LFS/usr

	popd
fi


