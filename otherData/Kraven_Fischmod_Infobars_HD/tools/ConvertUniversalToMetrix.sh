#!/bin/sh

cat ../../../allScreens/skin_Kraven_Fischmod_Infobars_HD.xml \
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
 > ../../../skinparts/Kraven_Fischmod_Infobars_HD/Kraven_Fischmod_Infobars_HD.xml 
