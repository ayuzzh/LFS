
import requests, os


packages_list = {
"Acl" : "https://download.savannah.gnu.org/releases/acl/acl-2.3.1.tar.xz",
"Autoconf" : "https://ftp.gnu.org/gnu/autoconf/autoconf-2.71.tar.xz",
"Automake" : "https://ftp.gnu.org/gnu/automake/automake-1.16.5.tar.xz",
"Bc" : "https://github.com/gavinhoward/bc/releases/download/6.2.4/bc-6.2.4.tar.xz",
"Binutils" : "https://sourceware.org/pub/binutils/releases/binutils-2.40.tar.xz",
"Bison" : "https://ftp.gnu.org/gnu/bison/bison-3.8.2.tar.xz",
"Coreutils" : "https://ftp.gnu.org/gnu/coreutils/coreutils-9.1.tar.xz",
"Diffutils" : "https://ftp.gnu.org/gnu/diffutils/diffutils-3.9.tar.xz",
"Expat" : "https://prdownloads.sourceforge.net/expat/expat-2.5.0.tar.xz",
"Findutils" : "https://ftp.gnu.org/gnu/findutils/findutils-4.9.0.tar.xz",
"Gawk" : "https://ftp.gnu.org/gnu/gawk/gawk-5.2.1.tar.xz",
"GCC" : "https://ftp.gnu.org/gnu/gcc/gcc-12.2.0/gcc-12.2.0.tar.xz",
"Gettext" : "https://ftp.gnu.org/gnu/gettext/gettext-0.21.1.tar.xz",
"Glibc" : "https://ftp.gnu.org/gnu/glibc/glibc-2.37.tar.xz",
"GMP" : "https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.xz",
"Grep" : "https://ftp.gnu.org/gnu/grep/grep-3.8.tar.xz",
"GRUB" : "https://ftp.gnu.org/gnu/grub/grub-2.06.tar.xz",
"Gzip" : "https://ftp.gnu.org/gnu/gzip/gzip-1.12.tar.xz",
"Inetutils" : "https://ftp.gnu.org/gnu/inetutils/inetutils-2.4.tar.xz",
"IPRoute2" : "https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.1.0.tar.xz",
"Kbd" : "https://www.kernel.org/pub/linux/utils/kbd/kbd-2.5.1.tar.xz",
"Kmod" : "https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-30.tar.xz",
"LFS-Bootscripts" : "https://www.linuxfromscratch.org/lfs/downloads/11.3/lfs-bootscripts-20230101.tar.xz",
"Libcap" : "https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.67.tar.xz",
"Libtool" : "https://ftp.gnu.org/gnu/libtool/libtool-2.4.7.tar.xz",
"Linux" : "https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.11.tar.xz",
"M4" : "https://ftp.gnu.org/gnu/m4/m4-1.4.19.tar.xz",
"Man-DB" : "https://download.savannah.gnu.org/releases/man-db/man-db-2.11.2.tar.xz",
"Man-pages" : "https://www.kernel.org/pub/linux/docs/man-pages/man-pages-6.03.tar.xz",
"MPFR" : "https://ftp.gnu.org/gnu/mpfr/mpfr-4.2.0.tar.xz",
"Patch" : "https://ftp.gnu.org/gnu/patch/patch-2.7.6.tar.xz",
"Perl" : "https://www.cpan.org/src/5.0/perl-5.36.0.tar.xz",
"Procps" : "https://sourceforge.net/projects/procps-ng/files/Production/procps-ng-4.0.2.tar.xz",
"Psmisc" : "https://sourceforge.net/projects/psmisc/files/psmisc/psmisc-23.6.tar.xz",
"Python" : "https://www.python.org/ftp/python/3.11.2/Python-3.11.2.tar.xz",
"Sed" : "https://ftp.gnu.org/gnu/sed/sed-4.9.tar.xz",
"Shadow" : "https://github.com/shadow-maint/shadow/releases/download/4.13/shadow-4.13.tar.xz",
"Sysvinit" : "https://github.com/slicer69/sysvinit/releases/download/3.06/sysvinit-3.06.tar.xz",
"Tar" : "https://ftp.gnu.org/gnu/tar/tar-1.34.tar.xz",
"Texinfo" : "https://ftp.gnu.org/gnu/texinfo/texinfo-7.0.2.tar.xz",
"Udev-lfs Tarball" : "https://anduin.linuxfromscratch.org/LFS/udev-lfs-20171102.tar.xz",
"Util-linux" : "https://www.kernel.org/pub/linux/utils/util-linux/v2.38/util-linux-2.38.1.tar.xz",
"Vim" : "https://anduin.linuxfromscratch.org/LFS/vim-9.0.1273.tar.xz",
"Xz Utils" : "https://tukaani.org/xz/xz-5.4.1.tar.xz",
"Zlib" : "https://zlib.net/zlib-1.2.13.tar.xz",

"Attr" :"https://download.savannah.gnu.org/releases/attr/attr-2.5.1.tar.gz",
"Bash" : "https://ftp.gnu.org/gnu/bash/bash-5.2.15.tar.gz",
"Bzip2" : "https://www.sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz",
"Check" : "https://github.com/libcheck/check/releases/download/0.15.2/check-0.15.2.tar.gz",
"E2fsprogs" : "https://downloads.sourceforge.net/project/e2fsprogs/e2fsprogs/v1.47.0/e2fsprogs-1.47.0.tar.gz",
"Eudev" : "https://github.com/eudev-project/eudev/releases/download/v3.2.11/eudev-3.2.11.tar.gz",
"Expect" : "https://prdownloads.sourceforge.net/expect/expect5.45.4.tar.gz",
"DejaGNU" : "https://ftp.gnu.org/gnu/dejagnu/dejagnu-1.6.3.tar.gz",
"File" : "https://astron.com/pub/file/file-5.44.tar.gz",
"Flex" : "https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz",
"GDBM" : "https://ftp.gnu.org/gnu/gdbm/gdbm-1.23.tar.gz",
"Gperf" : "https://ftp.gnu.org/gnu/gperf/gperf-3.1.tar.gz",
"Groff" : "https://ftp.gnu.org/gnu/groff/groff-1.22.4.tar.gz",
"Iana-Etc" : "https://github.com/Mic92/iana-etc/releases/download/20230202/iana-etc-20230202.tar.gz",
"Intltool" : "https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz",
"Less" : "https://www.greenwoodsoftware.com/less/less-608.tar.gz",
"Libffi" : "https://github.com/libffi/libffi/releases/download/v3.4.4/libffi-3.4.4.tar.gz",
"Libpipeline" : "https://download.savannah.gnu.org/releases/libpipeline/libpipeline-1.5.7.tar.gz",
"Make" : "https://ftp.gnu.org/gnu/make/make-4.4.tar.gz",
"Meson" : "https://github.com/mesonbuild/meson/releases/download/1.0.0/meson-1.0.0.tar.gz",
"MPC" : "https://ftp.gnu.org/gnu/mpc/mpc-1.3.1.tar.gz",
"Ncurses" : "https://invisible-mirror.net/archives/ncurses/ncurses-6.4.tar.gz",
"Ninja" : "https://github.com/ninja-build/ninja/archive/v1.11.1/ninja-1.11.1.tar.gz",
"OpenSSL" : "https://www.openssl.org/source/openssl-3.0.8.tar.gz",
"Pkg-config" : "https://pkg-config.freedesktop.org/releases/pkg-config-0.29.2.tar.gz",
"Readline" : "https://ftp.gnu.org/gnu/readline/readline-8.2.tar.gz",
"Sysklogd" : "https://www.infodrom.org/projects/sysklogd/download/sysklogd-1.5.1.tar.gz",
"Tcl" : "https://downloads.sourceforge.net/tcl/tcl8.6.13-src.tar.gz",
"Tcl Documentation" : "https://downloads.sourceforge.net/tcl/tcl8.6.13-html.tar.gz",
"Time Zone Data" : "https://www.iana.org/time-zones/repository/releases/tzdata2022g.tar.gz",
"Wheel" : "https://pypi.org/packages/source/w/wheel/wheel-0.38.4.tar.gz",
"XML::Parser" : "https://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.46.tar.gz",
"Zstd" : "https://github.com/facebook/zstd/releases/download/v1.5.4/zstd-1.5.4.tar.gz",

"Python Documentation" : "https://www.python.org/ftp/python/doc/3.11.2/python-3.11.2-docs-html.tar.bz2",
"Elfutils" : "https://sourceware.org/ftp/elfutils/0.188/elfutils-0.188.tar.bz2"
}


patches_list = {
"Bzip2" : "https://www.linuxfromscratch.org/patches/lfs/11.3/bzip2-1.0.8-install_docs-1.patch",
"Coreutils Internationalization Fixes Patch" : "https://www.linuxfromscratch.org/patches/lfs/11.3/coreutils-9.1-i18n-1.patch",
"Glibc FHS Patch" : "https://www.linuxfromscratch.org/patches/lfs/11.3/glibc-2.37-fhs-1.patch",
"GRUB Upstream Fixes Patch" : "https://www.linuxfromscratch.org/patches/lfs/11.3/grub-2.06-upstream_fixes-1.patch",
"Kbd Backspace/Delete Fix Patch " : "https://www.linuxfromscratch.org/patches/lfs/11.3/kbd-2.5.1-backspace-1.patch",
"Readline Upstream Fix Patch" : "https://www.linuxfromscratch.org/patches/lfs/11.3/readline-8.2-upstream_fix-1.patch",
"Sysvinit Consolidated Patch" : "https://www.linuxfromscratch.org/patches/lfs/11.3/sysvinit-3.06-consolidated-1.patch"
}



# Downloading packages

for i in packages_list:
	package = (packages_list[i])
	package_file_name = os.path.basename(package[6:])
	if not os.path.isfile("lfs/sources/packages/" + package_file_name):
		print("[Downloading] " + package_file_name)
		response = requests.get(package, stream=True)
		with open("lfs/sources/packages/" + package_file_name, "wb") as out_file:
			out_file.write(response.content)

print("All packages have been downloaded.")

for i in patches_list:
	patch = (patches_list[i])
	patch_file_name = os.path.basename(patch[6:])
	if not os.path.isfile("lfs/sources/patches/" + patch_file_name):
		print("[Downloading] " + patch_file_name)
		response = requests.get(patch, stream=True)
		with open("lfs/sources/patches/" + patch_file_name, "wb") as out_file:
			out_file.write(response.content)

print("All patches have been downloaded.")


