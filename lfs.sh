#!/bin/bash

export LFS=/home/lfs/project-lfs/lfs
export LFS_TGT=x86_64-lfs-linux-gnu

export MAKEFLAGS='j1'

export NOW=$(date +'%Y/%m/%d/%R')
export SCRIPTS=$LFS/../scripts

mkdir -pv $LFS
mkdir -pv $LFS/../log/$NOW

# Preliminary scripts for setting up build disk and file system
source $SCRIPTS/build_preparations/setup_build_disk.sh
source $SCRIPTS/build_preparations/setup_file_system.sh

# Downloading source packages and patches
python3 $SCRIPTS/packages.py

# Scripts for compiling tool chain
source $SCRIPTS/cross_tool_chain/binutils.sh |& tee $LFS/../log/$NOW/binutils.log
source $SCRIPTS/cross_tool_chain/gcc.sh |& tee $LFS/../log/$NOW/gcc.log
source $SCRIPTS/cross_tool_chain/linux_api_headers.sh |& tee $LFS/../log/$NOW/linux_api_headers.log
source $SCRIPTS/cross_tool_chain/glibc.sh |& tee $LFS/../log/$NOW/glibc.log
source $SCRIPTS/cross_tool_chain/libstdc++.sh |& tee $LFS/../log/$NOW/libstdc++.log

# Compiling packages using already compiled tool chain
source $SCRIPTS/temporary_tools/m4.sh |& tee $LFS/../log/$NOW/binutils.log
source $SCRIPTS/temporary_tools/ncurses.sh |& tee $LFS/../log/$NOW/binutils.log



source $SCRIPTS/build_preparations/unmount_build_disk.sh

