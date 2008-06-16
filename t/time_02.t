#!/usr/bin/perl -w
#package time_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D::Time';
	use_ok 'X3D::Math';
}

ok X3DMath::sum( map { time =~ m/\./ } 1 .. 170 ) <= 170 foreach 1 .. 10;

no X3D::Time;

ok !X3DMath::sum( map { time =~ m/\./ ? 1 : 0 } 1 .. 170 ) foreach 1 .. 10;

__END__
