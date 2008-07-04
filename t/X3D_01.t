#!/usr/bin/perl -w
#package X3D_Core_01
use Test::More no_plan;
use strict;

BEGIN {
   $| = 1;
   chdir 't' if -d 't';
   unshift @INC, '../lib';
   use_ok 'X3D';
}

print new X3D;
__END__
