#!/usr/bin/perl -w
#package testnode2_05
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
	use_ok 'TestNodeFields';
}

my $testNode = new TestNode;
ok UNIVERSAL::isa( $testNode, 'X3D::Universal' );
ok $testNode->UNIVERSAL::isa('X3DBaseNode');

is $testNode->isa, '1 2';

#isa_ok $testNode->isa, '';
#isa_ok $testNode->can, '';

is $testNode, 'TestNode { }';

my $hash = {};
ok 0 == scalar keys %$hash;
ok !%$hash;
print scalar %$hash;

ok my $parents = $testNode->sfbool->getParents;

ok $testNode->sfbool->getParents == 1;

1;
__END__
print $testNode->X3D::Package::stringify;
print $_ foreach $testNode->getHierarchy;




