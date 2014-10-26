#!/usr/bin/perl -w
#package namespace_01
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
}

my $DEBUG = 0;

SKIP: {
	skip "Not necessary" unless $DEBUG;

	my $perl = {};
	my $X3D = [];

	no strict;
	foreach my $subpkg ( sort keys( %{ *{"main::"} } ) )
	{
		$perl->{$subpkg} = 1;
		#print "package main contains package '$subpkg'";
	}

	use_ok 'X3D';

	foreach my $subpkg ( sort keys( %{ *{"main::"} } ) )
	{
		push @$X3D, $subpkg unless exists $perl->{$subpkg};
		#print "package main contains package '$subpkg'";

		if ( $subpkg =~ /::$/o ) {
			foreach my $subsubpkg ( sort keys( %{ *{"$subpkg"} } ) )
			{
				#print "  package $subpkg contains package ' $subsubpkg'";
			}
		}

	}

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

__END__


