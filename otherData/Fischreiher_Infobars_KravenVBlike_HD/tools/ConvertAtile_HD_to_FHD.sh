#!/bin/sh

file_Atile_HD=../../../skinparts/Fischreiher_Infobars_KravenVBlike_HD/Fischreiher_Infobars_KravenVBlike_HD_Atile.xml
file_Atile_FHD=../../../skinparts/Fischreiher_Infobars_KravenVBlike_FHD/Fischreiher_Infobars_KravenVBlike_FHD_Atile.xml

./skin_scale.pl 1280x720 1920x1080 auto $file_Atile_HD $file_Atile_FHD

sed -r -i 's|/icons_HD/|/icons_FHD/|g'     $file_Atile_FHD
sed -r -i 's|HD\s+section\s|FHD section|g' $file_Atile_FHD
