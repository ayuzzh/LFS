#!/bin/bash

export LFS=/home/lfs/project-lfs/lfs
export LFS_TGT=x86_64-lfs-linux-gnu

export MAKEFLAGS='j1'

export NOW=$(date +'%Y/%m/%d/%R')
export SCRIPTS=$LFS/../scripts

mkdir -pv $LFS
mkdir -pv $LFS/../log/$NOW

# Preliminary scripts for setting up build disk and file system
source $SCRIPTS/build_preparation/setup_build_disk.sh
source $SCRIPTS/build_preparation/setup_file_system.sh

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
source $SCRIPTS/temporary_tools/bash.sh |& tee $LFS/../log/$NOW/bash.log
source $SCRIPTS/temporary_tools/coreutils.sh |& tee $LFS/../log/$NOW/coreutils.log
source $SCRIPTS/temporary_tools/diffutils.sh |& tee $LFS/../log/$NOW/diffutils.log
source $SCRIPTS/temporary_tools/findutils.sh |& tee $LFS/../log/$NOW/findutils.log
source $SCRIPTS/temporary_tools/file.sh |& tee $LFS/../log/$NOW/file.log
source $SCRIPTS/temporary_tools/gawk.sh |& tee $LFS/../log/$NOW/gawk.log
source $SCRIPTS/temporary_tools/grep.sh |& tee $LFS/../log/$NOW/grep.log
source $SCRIPTS/temporary_tools/gzip.sh |& tee $LFS/../log/$NOW/gzip.log
source $SCRIPTS/temporary_tools/make.sh |& tee $LFS/../log/$NOW/make.log
source $SCRIPTS/temporary_tools/sed.sh |& tee $LFS/../log/$NOW/sed.log
source $SCRIPTS/temporary_tools/tar.sh |& tee $LFS/../log/$NOW/tar.log
source $SCRIPTS/temporary_tools/tar.sh |& tee $LFS/../log/$NOW/tar.log
source $SCRIPTS/temporary_tools/xz.sh |& tee $LFS/../log/$NOW/xz.log
source $SCRIPTS/temporary_tools/patch.sh |& tee $LFS/../log/$NOW/patch.log



source $SCRIPTS/build_preparation/unmount_build_disk.sh

