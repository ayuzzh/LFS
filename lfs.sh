#!/bin/bash

export LFS=/home/lfs/project/os
export LFS_TGT=x86_64-lfs-linux-gnu

export MAKEFLAGS='j1'

export NOW=$(date +'%Y/%m/%d/%R')
export SCRIPTS=$LFS/../scripts

mkdir -pv $LFS
mkdir -pv $LFS/../log/$NOW

# Preliminary scripts for setting up build disk and file system
source $SCRIPTS/setup_build_disk.sh
source $SCRIPTS/setup_file_system.sh

# Downloading source packages and patches
python3 $SCRIPTS/packages.py

# Scripts for compiling tool chain
source $SCRIPTS/binutils.sh |& tee $LFS/../log/$NOW/binutils.log
source $SCRIPTS/gcc.sh |& tee $LFS/../log/$NOW/gcc.log
source $SCRIPTS/linux_api_headers.sh |& tee $LFS/../log/$NOW/linux_api_headers.log
source $SCRIPTS/glibc.sh |& tee $LFS/../log/$NOW/glibc.log
source $SCRIPTS/libstdc++.sh |& tee $LFS/../log/$NOW/libstdc++.log

# Compiling packages using already compiled tool chain
source $SCRIPTS/pass1_packages.sh



source $SCRIPTS/unmount_build_disk.sh

