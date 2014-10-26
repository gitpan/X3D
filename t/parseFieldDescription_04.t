#!/usr/bin/perl -w
#package parseFieldDescription_04
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}
use X3D;

ok not eval { X3D::Parse::FieldDescription::parse "SFNode [] metadata NU LL" };
ok $@; ok eval { 1 };

ok X3D::Parse::FieldDescription::parse "SFNode [] metadata NULL";
ok X3D::Parse::FieldDescription::parse "SFNode [in] metadata";
ok X3D::Parse::FieldDescription::parse "SFNode [out] metadata";
ok X3D::Parse::FieldDescription::parse "SFNode [in,out] metadata NULL";

ok my $fieldDescription = X3D::Parse::FieldDescription::parse "SFNode [in,out] metadata NULL [X3DMetadataObject]";
ok @$fieldDescription;
is shift @{ $fieldDescription->[0] }, 'SFNode';
is shift @{ $fieldDescription->[0] }, YES;
is shift @{ $fieldDescription->[0] }, YES;
is shift @{ $fieldDescription->[0] }, 'metadata';
is shift @{ $fieldDescription->[0] }, undef;
is shift @{ $fieldDescription->[0] }, '[X3DMetadataObject]';

ok $fieldDescription = X3D::Parse::FieldDescription::parse "SFBool [in,out] metadata TRUE [X3DMetadataObject]";
ok @$fieldDescription;
is shift @{ $fieldDescription->[0] }, 'SFBool';
is shift @{ $fieldDescription->[0] }, YES;
is shift @{ $fieldDescription->[0] }, YES;
is shift @{ $fieldDescription->[0] }, 'metadata';
is shift @{ $fieldDescription->[0] }, YES;
is shift @{ $fieldDescription->[0] }, '[X3DMetadataObject]';

1;
__END__

