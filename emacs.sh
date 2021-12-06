#!/bin/bash

yes | paru -S libgccjit
git clone https://github.com/emacs-mirror/emacs/ ~/.cache/emacs_mirror/
cd ~/.cache/emacs_mirror/
./autogen
./configure --with-native-compilation --with-mailutils --with-sound=yes--with-imagemagick --without-xwidgets --with-jpeg --with-png --with-rsvg --with-tiff --with-wide-int --with-xft --with-xml2 --with-xpm --with-gnutls --without-toolkit-scroll-bars CFLAGS='-O2 -march=native'
make NATIVE_FULL_AOT=1 -j$(nproc)
sudo make install
cd
rm -rf ~/.cache/emacs_mirror/
