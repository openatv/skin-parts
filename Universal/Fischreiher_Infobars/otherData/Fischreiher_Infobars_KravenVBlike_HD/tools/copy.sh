#!/bin/sh

#rm -rf ~/R/usr/share/enigma2/MetrixHD/allScreens 
#rm -rf ~/R/usr/share/enigma2/MetrixHD/skinparts
#rm -rf ~/R/usr/share/enigma2/DMConcinnity-HD/allScreens
#rm -rf ~/R/usr/share/enigma2/DMConcinnity-HD/skinparts
rm -rf ~/R/usr/share/enigma2/skinparts

cp -ar ../../../skinparts  ~/R/usr/share/enigma2

#rsync --del -va ../../../skinparts  ~/R/usr/share/enigma2

#cp -ar ../../../skinparts/Fischreiher_Infobars_KravenVBlike_HD/Fischreiher_Infobars_KravenVBlike_HD*  ~/R/usr/share/enigma2/skinparts/Fischreiher_Infobars_KravenVBlike_HD/

