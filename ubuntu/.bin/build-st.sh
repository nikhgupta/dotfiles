#!/usr/bin/env sh

stdir="${HOME}/aur/st-scrollback-git"
cd $stdir
#rm -fr config.def.h st/ st-scrollback-git-*.pkg.tar.xz st-*.diff src/ pkg/
rm -f st-scrollback-git-*.pkg.tar.xz
#nano config.h
makepkg -isc
