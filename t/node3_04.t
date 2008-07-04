#!/usr/bin/perl -w
#package node3_04
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
	use_ok 'TestNodeX3D';
}

ok my $X3D = new X3DTest;
isa_ok $X3D, $_ foreach @{ $X3D->X3DPackage::getPath };
ok $X3D ;
isa_ok $X3D, $_ foreach @{  $X3D->getHierarchy };
ok $X3D ;
printf "%s\n", $X3D;
is $X3D, "X3DTest { }";

X3DGenerator->setTidyFields(YES);
printf "%s\n", $X3D;
X3DGenerator->setTidyFields(NO);
printf "%s\n", $X3D;
print $_ foreach $X3D->getFieldDefinitions;

1;
__END__
