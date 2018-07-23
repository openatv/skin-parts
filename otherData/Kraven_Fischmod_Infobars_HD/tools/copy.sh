#!/bin/sh

rm -rf ~/R/usr/share/enigma2/MetrixHD/allScreens 
rm -rf ~/R/usr/share/enigma2/MetrixHD/skinparts
rm -rf ~/R/usr/share/enigma2/DMConcinnity-HD/allScreens
rm -rf ~/R/usr/share/enigma2/DMConcinnity-HD/skinparts

cp -ar ../../../allScreens ~/R/usr/share/enigma2/MetrixHD
cp -ar ../../../skinparts  ~/R/usr/share/enigma2/MetrixHD
cp -ar ../../../allScreens ~/R/usr/share/enigma2/DMConcinnity-HD
cp -ar ../../../skinparts  ~/R/usr/share/enigma2/DMConcinnity-HD

