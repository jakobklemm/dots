#!/bin/bash

yes | paru -S libgccjit
git clone https://github.com/emacs-mirror/emacs/ ~/.cache/emacs_mirror/
cd ~/.cache/emacs_mirror/
./autogen
./configure --with-native-compilation --with-mailutils --with-sound=yes CFLAGS='-O3 -march=native'
make NATIVE_FULL_AOT=1 -j$(nproc)
sudo make install
cd
rm -rf ~/.cache/emacs_mirror/
