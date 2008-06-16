#!/usr/bin/perl -w
#package X3D_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
}
package main;

use_ok 'X3D' for 1 .. 10;

do { use X3D } for 1 .. 10;

ok 'X3D'->VERSION;

eval { new main };
ok not @!;

__END__

