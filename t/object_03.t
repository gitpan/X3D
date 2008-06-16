#!/usr/bin/perl -w
#package object_03
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

ok new X3DObject;
ok my $object = new X3DObject;

print new X3DHash(\%$object);


1;
__END__
