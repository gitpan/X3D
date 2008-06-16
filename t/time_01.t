#!/usr/bin/perl -w
#package time_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

package test;
use X3D::Universal;

Test::More::ok X3DMath::sum( map { time =~ m/\./ } 1 .. 170 ) <= 170 foreach 1 .. 10;

package main;
use X3D::Perl;

ok X3DMath::sum( map { time =~ m/\./ } 1 .. 170 ) <= 170 foreach 1 .. 10;

__END__

