#!/usr/bin/perl -w
#package hierarchy_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

no strict;
my $X3D = new X3DArray [ sort map { s/\:\:$//o; $_ } grep /^X3D|MF|SF/o, keys( %{ *{"main::"} } ) ];
use strict;
#print $X3D;

print reverse $_->getHierarchy foreach grep { $_->can('getHierarchy') } @$X3D;

package xxx;
use X3D 'fds';

print fds->X3DPackage::toString;
1;
__END__


my $DEBUG = 0;

SKIP: {
	skip "Not necessary" unless $DEBUG;


	print $_ foreach @$X3D;

	my $pack = "CORE::GLOBAL";
	foreach my $subpkg ( sort keys( %{ *{"$pack\::"} } ) )
	{
		print "package $pack contains package '$subpkg'";
		foreach my $subsubpkg ( sort keys( %{ *{"main::"}{HASH}->{$subpkg} } ) )
		{
			print "package '$subpkg' contains package '$subsubpkg'";
		}
	}

}

