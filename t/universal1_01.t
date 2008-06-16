#!/usr/bin/perl -w
#package universal1_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

ok !X3D::Universal->X3D::Package::Array('ISA');

is( ref( ( X3D::Universal->X3D::Package::can('import') )[0] ), 'CODE' );

ok !X3D::Universal->X3D::Package::can('blah');

my $o = new SFNode;

print X3DUniversal::getId(new SFNode);
print X3DUniversal::getId(\"dsfd");


__END__



