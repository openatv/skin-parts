#!/bin/sh

file_Atile_HD=../../../skinparts/Fischreiher_Infobars_KravenVBlike_HD/Fischreiher_Infobars_KravenVBlike_HD_Atile.xml
file_Metrix_HD=../../../skinparts/Fischreiher_Infobars_KravenVBlike_HD/Fischreiher_Infobars_KravenVBlike_HD.xml

cat $file_Atile_HD \
\
| sed -e "s|\"KravenIBbg\"|\"black\"|g" \
| sed -e "s|\"KravenIBFont1\"|\"white\"|g" \
| sed -e "s|\"KravenIBFont2\"|\"#00F8CA8C\"|g" \
| sed -e "s|\"KravenLine\"|\"white\"|g" \
| sed -e "s|\"KravenProgress\"|\"#00C3461B\"|g" \
\
| sed -e "s|\"KravenVBRegular\s*;|\"Regular;|g" \
\
| perl -0777 -pe 's|\ *<output\s.*</output>\ *\n||igs' \
| perl -0777 -pe 's|\ *<colors>.*</colors>\ *\n||igs' \
| perl -0777 -pe 's|\ *<fonts>.*</fonts>\ *\n||igs' \
| perl -0777 -pe 's|\ *<parameters>.*</parameters>\ *\n||igs' \
\
| grep -v "<skin>" \
| grep -v "</skin>" \
\
 > $file_Atile_HD.part_HD
 
./skin_scale.pl 1280x720 1920x1080 auto $file_Atile_HD.part_HD $file_Atile_HD.part_FHD

sed -r -i 's|screen\s+name=\"([A-Za-z0-9\_]+)\"|screen\ name=\"\1#_FHDscreen\"|g' $file_Atile_HD.part_FHD
sed -r -i 's|/icons_HD/|/icons_FHD/|g'     $file_Atile_HD.part_FHD
sed -r -i 's|HD\s+section\s|FHD section|g' $file_Atile_HD.part_FHD

echo "<skin>"                > $file_Metrix_HD
cat $file_Atile_HD.part_HD  >> $file_Metrix_HD
cat $file_Atile_HD.part_FHD >> $file_Metrix_HD
echo "</skin>"              >> $file_Metrix_HD
