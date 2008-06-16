#!/usr/bin/perl -w
#package namespace_02
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

is (X3DPackage->getNamespace, '');
X3D::Namespace->import('X3D');
is (X3DPackage->getNamespace, 'X3D');
X3D::Namespace->unimport;
is (X3DPackage->getNamespace, '');
X3D::Namespace->import('X3D');
is (X3DPackage->getNamespace, 'X3D');
X3D::Namespace->unimport;
is (X3DPackage->getNamespace, '');

1;
__END__
