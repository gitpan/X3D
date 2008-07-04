#!/usr/bin/perl -w
#package nodefield_hierarchy_06
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
	use_ok 'TestNodeFields';
}

ok my $testNode = new TestNode;
#$testNode->sfdouble(123);

isa_ok $testNode->getField("sfdouble"),    'X3DField';
isa_ok $testNode->getField("say"),         'X3DField';
isa_ok $testNode->getField("time"),        'X3DField';
isa_ok $testNode->getField("parseFloat"), 'X3DField';
isa_ok $testNode->getField("parseInt"),    'X3DField';
isa_ok $testNode->getField("übelst"),      'X3DField';
isa_ok $testNode->getField("übe::lst"),    'X3DField';
#isa_ok $testNode->getValue->getField("3übe::lst"), 'X3DField';

#is $testNode->YES, YES;
#is $testNode->NO,  NO;

is $testNode->sfdouble->X3DPackage::toString,
  'SFDouble [
  X3D::FieldTypes::SFDouble [ X3D::BaseFieldTypes::Scalar [] ]
  X3DField [
    X3D::Field []
    X3DObject [
      X3D::Object []
      X3DUniversal [ X3D::Universal [] ]
    ]
  ]
]';

################################################################################
my $tw = 20;
my $m  = $tw;
$m = ++$m + $m++;
$testNode->sfdouble = $tw;
is ++$testNode->sfdouble + $testNode->sfdouble++, $m;

$m                 = $tw;
$m                 = ++$m + $m++;
$testNode->sffloat = $tw;
is ++$testNode->sffloat + $testNode->sffloat++, $m;

1;
__END__

