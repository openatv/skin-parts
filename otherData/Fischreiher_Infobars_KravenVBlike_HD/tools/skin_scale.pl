#!/usr/bin/perl -w
use strict;

#=========================================================================
# skin scaler
#
# usage:
# skin_scale.pl old_res new_res text_scale in_file out_file
#
# text_scale options:
#   auto_x    ... scale like ratio new/old res. in x (for matching text width)
#   auto_y    ... scale like ratio new/old res. in y (for matching text height)
#   auto      ... scale like ratio new/old res., average of x and y
#   105       ... scale by factor (in percent, 100 = no scaling)
#
# example:
# skin_scale.pl 400x200 480x320 auto_x display400/skin_display_picon.xml display480/skin_display_picon.xml
#=========================================================================
# openATV Fischreiher
#=========================================================================

my @read_data;
my $line;
my $font;
my $pixmap;
my $old_res = $ARGV[0];
my $new_res = $ARGV[1];
my $text_scale = $ARGV[2];
my $old_res_x;
my $old_res_y;
my $new_res_x;
my $new_res_y;
my $x;
my $y;
my $h;
my $x_scaled;
my $y_scaled;
my $h_scaled;

if ($old_res =~ /\s*([-0-9]+)\s*x\s*([-0-9]+)\s*/) {
    $old_res_x = $1;
    $old_res_y = $2;
} else {
    die("Could not interpret old resolution, found $old_res, expected e.g. 320x200");
}

if ($new_res =~ /\s*([-0-9]+)\s*x\s*([-0-9]+)\s*/) {
    $new_res_x = $1;
    $new_res_y = $2;
} else {
    die("Could not interpret new resolution, found $new_res, expected e.g. 320x200");
}

if ($text_scale eq "auto_x") {
    $text_scale = 100*$new_res_x/$old_res_x;
} elsif ($text_scale eq "auto_y") {
    $text_scale = 100*$new_res_y/$old_res_y;
} elsif ($text_scale eq "auto") {
    $text_scale = 100*sqrt(($new_res_x*$new_res_y)/($old_res_x*$old_res_y));
} elsif ($text_scale =~ /^([0-9\.]+)$/) {
    $text_scale = $text_scale;
} else {
    die("Could not interpret text_scale, found $text_scale, expected auto_x, auto_y, auto, or a number used as percentage");
}

open(INFILE, "<$ARGV[3]") or die("Could not open file$ARGV[3]");
open(OUTFILE,">$ARGV[4]") or die("Could not open file$ARGV[4]");

@read_data = <INFILE>;
close(INFILE);
#chomp(@read_data);
foreach $line (@read_data){



    # resolution xres="1280" yres="720"

    if ($line =~ /resolution\s+xres\s*=\s*\&quot;\s*([-0-9]+)\s*\&quot;\s+yres\s*=\s*\&quot;\s*([-0-9]+)\s*\&quot;/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $x = $1;
        $y = $2;
        $x_scaled = int($x*$new_res_x/$old_res_x+0.5);
        $y_scaled = int($y*$new_res_y/$old_res_y+0.5);
        $line =~ s/resolution\s+xres\s*=\s*\&quot;$x\&quot;\s+yres\s*=\s*\&quot;$y\&quot;/resolution xres=\&quot;$x_scaled\&quot; yres=\&quot;$y_scaled\&quot;/m;
    }
    if ($line =~ /resolution\s+xres\s*=\s*\"\s*([-0-9]+)\s*\"\s+yres\s*=\s*\"\s*([-0-9]+)\s*\"/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $x = $1;
        $y = $2;
        $x_scaled = int($x*$new_res_x/$old_res_x+0.5);
        $y_scaled = int($y*$new_res_y/$old_res_y+0.5);
        $line =~ s/resolution\s+xres\s*=\s*\"$x\"\s+yres\s*=\s*\"$y\"/resolution xres=\"$x_scaled\" yres=\"$y_scaled\"/m;
    }

    # size="x,y"

    if ($line =~ /size\s*=\s*\(\s*([-0-9]+)\s*,\s*([-0-9]+)\s*\)/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $x = $1;
        $y = $2;
        $x_scaled = int($x*$new_res_x/$old_res_x+0.5);
        $y_scaled = int($y*$new_res_y/$old_res_y+0.5);
        $line =~ s/size\s*=\s*\(\s*$x\s*,\s*$y\s*\)/size=($x_scaled,$y_scaled)/m;
    }
    if ($line =~ /size\s*=\s*\&quot;\s*([-0-9]+)\s*,\s*([-0-9]+)\s*\&quot;/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $x = $1;
        $y = $2;
        $x_scaled = int($x*$new_res_x/$old_res_x+0.5);
        $y_scaled = int($y*$new_res_y/$old_res_y+0.5);
        $line =~ s/size\s*=\s*\&quot;\s*$x\s*,\s*$y\s*\&quot;/size=\&quot;$x_scaled,$y_scaled\&quot;/m;
    }
    if ($line =~ /size\s*=\s*\"\s*([-0-9]+)\s*,\s*([-0-9]+)\s*\"/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $x = $1;
        $y = $2;
        $x_scaled = int($x*$new_res_x/$old_res_x+0.5);
        $y_scaled = int($y*$new_res_y/$old_res_y+0.5);
        $line =~ s/size\s*=\s*\"\s*$x\s*,\s*$y\s*\"/size=\"$x_scaled,$y_scaled\"/m;
    }

    # pos="x,y"

    if ($line =~ /pos\s*=\s*\(\s*([-0-9]+)\s*,\s*([-0-9]+)\s*\)/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $x = $1;
        $y = $2;
        $x_scaled = int($x*$new_res_x/$old_res_x+0.5);
        $y_scaled = int($y*$new_res_y/$old_res_y+0.5);
        $line =~ s/pos\s*=\s*\(\s*$x\s*,\s*$y\s*\)/pos=($x_scaled,$y_scaled)/m;
    }
    if ($line =~ /pos\s*=\s*\&quot;\s*([-0-9]+)\s*,\s*([-0-9]+)\s*\&quot;/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $x = $1;
        $y = $2;
        $x_scaled = int($x*$new_res_x/$old_res_x+0.5);
        $y_scaled = int($y*$new_res_y/$old_res_y+0.5);
        $line =~ s/pos\s*=\s*\&quot;\s*$x\s*,\s*$y\s*\&quot;/pos=\&quot;$x_scaled,$y_scaled\&quot;/m;
    }
    if ($line =~ /pos\s*=\s*\"\s*([-0-9]+)\s*,\s*([-0-9]+)\s*\"/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $x = $1;
        $y = $2;
        $x_scaled = int($x*$new_res_x/$old_res_x+0.5);
        $y_scaled = int($y*$new_res_y/$old_res_y+0.5);
        $line =~ s/pos\s*=\s*\"\s*$x\s*,\s*$y\s*\"/pos=\"$x_scaled,$y_scaled\"/m;
    }

    # position="x,y"

    if ($line =~ /position\s*=\s*\(\s*([-0-9]+)\s*,\s*([-0-9]+)\s*\)/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $x = $1;
        $y = $2;
        $x_scaled = int($x*$new_res_x/$old_res_x+0.5);
        $y_scaled = int($y*$new_res_y/$old_res_y+0.5);
        $line =~ s/position\s*=\s*\(\s*$x\s*,\s*$y\s*\)/position=($x_scaled,$y_scaled)/m;
    }
    if ($line =~ /position\s*=\s*\&quot;\s*([-0-9]+)\s*,\s*([-0-9]+)\s*\&quot;/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $x = $1;
        $y = $2;
        $x_scaled = int($x*$new_res_x/$old_res_x+0.5);
        $y_scaled = int($y*$new_res_y/$old_res_y+0.5);
        $line =~ s/position\s*=\s*\&quot;\s*$x\s*,\s*$y\s*\&quot;/position=\&quot;$x_scaled,$y_scaled\&quot;/m;
    }
    if ($line =~ /position\s*=\s*\"\s*([-0-9]+)\s*,\s*([-0-9]+)\s*\"/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $x = $1;
        $y = $2;
        $x_scaled = int($x*$new_res_x/$old_res_x+0.5);
        $y_scaled = int($y*$new_res_y/$old_res_y+0.5);
        $line =~ s/position\s*=\s*\"\s*$x\s*,\s*$y\s*\"/position=\"$x_scaled,$y_scaled\"/m;
    }

    # position="x,center"

    if ($line =~ /position\s*=\s*\&quot;\s*([-0-9]+)\s*,\s*center\s*\&quot;/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $x = $1;
        $x_scaled = int($x*$new_res_x/$old_res_x+0.5);
        $line =~ s/position\s*=\s*\&quot;\s*$x\s*,\s*center\s*\&quot;/position=\&quot;$x_scaled,center\&quot;/m;
    }
    if ($line =~ /position\s*=\s*\"\s*([-0-9]+)\s*,center\"/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $x = $1;
        $x_scaled = int($x*$new_res_x/$old_res_x+0.5);
        $line =~ s/position\s*=\s*\"\s*$x\s*,\s*center\s*\"/position=\"$x_scaled,center\"/m;
    }

    # position="center,y"

    if ($line =~ /position\s*=\s*\&quot;\s*center\s*,\s*([-0-9]+)\s*\&quot;/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $y = $1;
        $y_scaled = int($y*$new_res_y/$old_res_y+0.5);
        $line =~ s/position\s*=\s*\&quot;\s*center\s*,\s*$y\s*\&quot;/position=\&quot;center,$y_scaled\&quot;/m;
    }
    if ($line =~ /position\s*=\s*\"center,\s*([-0-9]+)\s*\"/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $y = $1;
        $y_scaled = int($y*$new_res_y/$old_res_y+0.5);
        $line =~ s/position\s*=\s*\"\s*center\s*,\s*$y\s*\"/position=\"center,$y_scaled\"/m;
    }

    # font="name;h"

    if ($line =~ /font\s*=\s*\(\s*([a-zA-Z0-9_]+)\s*;\s*([-0-9]+)\s*\)/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $font = $1;
        $h = $2;
        $h_scaled = int($h*$text_scale/100+0.5);
        $line =~ s/font\s*=\s*\(\s*$font\s*;\s*$h\s*\)/font=($font;$h_scaled)/m;
    }
    if ($line =~ /font\s*=\s*\&quot;\s*([a-zA-Z0-9_]+)\s*;\s*([-0-9]+)\s*\&quot;/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $font = $1;
        $h = $2;
        $h_scaled = int($h*$text_scale/100+0.5);
        $line =~ s/font\s*=\s*\&quot;\s*$font\s*;\s*$h\s*\&quot;/font=\&quot;$font;$h_scaled\&quot;/m;
    }
    if ($line =~ /font\s*=\s*\"\s*([a-zA-Z0-9_]+)\s*;\s*([-0-9]+)\s*\"/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $font = $1;
        $h = $2;
        $h_scaled = int($h*$text_scale/100+0.5);
        $line =~ s/font\s*=\s*\"\s*$font\s*;\s*$h\s*\"/font=\"$font;$h_scaled\"/m;
    }

    # gFont("name",h)

    if ($line =~ /gFont\(\s*\"([a-zA-Z0-9_]+)\"\s*,\s*([-0-9]+)\s*\)/) {
        #print "input line: ".$line;
        #print "found: ".$1." ".$2;
        $font = $1;
        $h = $2;
        $h_scaled = int($h*$text_scale/100+0.5);
        $line =~ s/gFont\(\s*\"$font\"\s*,\s*$h\s*\)/gFont(\"$font\",$h_scaled)/m;
    }

    # "itemHeight": h

    if ($line =~ /\"itemHeight\":\s*([-0-9]+)\s*/) {
        #print "input line: ".$line;
        #print "found: ".$1;
        $h = $1;
        $h_scaled = int($h*$text_scale/100+0.5);
        $line =~ s/\"itemHeight\":\s*$h\s*/\"itemHeight\":$h_scaled/m;
    }
    print(OUTFILE $line);
}
close(OUTFILE);
