#!/usr/bin/env python
import fnmatch
import os
import re

TEST = 0

if (TEST):
    # https://github.com/opendreambox/enigma2-skins
    MY_TOP_DIR    = 'skins'
    MY_BOX_DIR    = ''
    MY_HEADER     = "AC_INIT([enigma2-skins],4.3.0,[https://github.com/opendreambox/enigma2-skins/issues])\n"
else:
    # https://github.com/openatv/skin-parts
    MY_TOP_DIR    = 'skinparts'
    MY_BOX_DIR    = 'skinparts'
    MY_HEADER     = "AC_INIT([skin-parts],4.3.0,[https://github.com/openatv/skin-parts/issues])\n"

MY_EXTENSIONS = {".xml":"0", ".gif":"0", ".jpg":"0", ".png":"0", ".conf":"0", ".ttf":"0", ".svg":"0"}

def makegen(path,top,meta):
    print path , top
    extensions = MY_EXTENSIONS.copy()
    dirs = []
    files = []
    if (top):
        dirs.append(MY_TOP_DIR)
    else:
        for f in os.listdir(path):
            ext = os.path.splitext(f)[1]
            if os.path.isdir(os.path.join(path, f)):
                if (f != 'CONTROL'):
                    dirs.append(f)
            else:
                if ((f != 'Makefile.am')) and ((not meta) or (ext == '.xml')):
                    files.append(f)
    fm=open(os.path.join(path, 'Makefile.am'), 'w+')
    if (len(dirs) > 0):
        fm.write("SUBDIRS = ")
        fm.write(' '.join(sorted(dirs, key=lambda v: v.upper())))
        fm.write("\n")
    if (not top):
        if meta:
            fm.write("installdir = $(datadir)/meta/")
        else:
            fm.write("installdir = $(datadir)/enigma2/" + re.sub('^./'+MY_TOP_DIR+'/', r''+MY_BOX_DIR+'/', path))
        fm.write("\n")
    if (len(files) > 0):
        if meta:
            fm.write("\n")
            fm.write("dist_install_DATA =")
        else:
            fm.write("install_DATA =")
        #fm.write(' '.join(sorted(files, key=lambda v: v.upper())))
        for f in sorted(files, key=lambda v: v.upper()):
            #print f
            ext = os.path.splitext(f)[1]
            #print ext
            if (ext in extensions) and (not meta):
                extensions[ext] = "found"
            else:
                fm.write(' ' + f)
        for e in extensions:
            if extensions[e] ==  "found":
                fm.write(' *' + e)
        fm.write("\n")
    fm.close()
    for d in dirs:
        if (d == 'meta'):
            makegen(os.path.join(path, d),0,1)
        else:
            makegen(os.path.join(path, d),0,0)
        
makegen(".",1,0)

fc=open('./configure.ac', 'w+')
fc.write(MY_HEADER)
fc.write("AM_INIT_AUTOMAKE([foreign])\n")
fc.write("\n")
fc.write("AM_PATH_PYTHON\n")
fc.write("\n")
fc.write("AC_OUTPUT([\n")
fc.write("Makefile\n")
matches = []
for root, dirnames, filenames in os.walk(MY_TOP_DIR):
    for filename in fnmatch.filter(filenames, 'Makefile.am'):
        matches.append(os.path.join(root, "Makefile") + "\n")
fc.write(''.join(sorted(matches, key=lambda v: v.upper())))
fc.write("])\n")
fc.close()
