#!/usr/bin/perl -w
#package field_sfint_05
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

ok my $int1 = new SFInt32(2.23);
is $int1, 2;
ok my $int2 = new SFInt32(23.2);
ok my $int3 = new SFInt32(232.0);
is $int1, 2;
is $int2, 23;
is $int3, 232;

__END__

