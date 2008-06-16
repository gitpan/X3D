#!/usr/bin/perl -w
#package concept_00
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D::Parse::Concept';
}

ok X3D::Parse::Concept::parse('a{}');
is ref X3D::Parse::Concept::parse('a{}'),   'HASH';
is ref X3D::Parse::Concept::parse('a {}'),  'HASH';
is ref X3D::Parse::Concept::parse('a { }'), 'HASH';
is ref X3D::Parse::Concept::parse('a{ }'),  'HASH';

ok X3D::Parse::Concept::parse('X3DNode {}')->{typeName},         'X3DNode';
ok X3D::Parse::Concept::parse('X3DChildNode {}')->{typeName},    'X3DChildNode';
ok X3D::Parse::Concept::parse('X3DCh::ildNode {}')->{typeName},  'X3DCh::ildNode';
ok X3D::Parse::Concept::parse('_X3DCh::ildNode {}')->{typeName}, '_X3DCh::ildNode';

is X3D::Parse::Concept::parse('X3DChildNode:X3DNode{}')->{typeName},   'X3DChildNode:X3DNode';
is X3D::Parse::Concept::parse('X3DChildNode : X3DNode{}')->{typeName}, 'X3DChildNode';
is X3D::Parse::Concept::parse('X3DChildNode : X3DNode{}')->{supertypes}->[0], 'X3DNode';
is X3D::Parse::Concept::parse('A : B C {}')->{typeName}, 'A';
is X3D::Parse::Concept::parse('A : B C {}')->{typeName}, 'A';
is X3D::Parse::Concept::parse('A : B C {}')->{supertypes}->[0],  'B';
is X3D::Parse::Concept::parse('A : B C {}')->{supertypes}->[1],  'C';
is X3D::Parse::Concept::parse('A : B C D{}')->{supertypes}->[2], 'D';

ok !X3D::Parse::Concept::parse('a :{}');
ok !X3D::Parse::Concept::parse('a : {}');
ok !X3D::Parse::Concept::parse('b :a {}');
ok X3D::Parse::Concept::parse('b : a {}');

ok X3D::Parse::Concept::parse('b : a {0}');
ok X3D::Parse::Concept::parse('b : a { 0 }')->{body}->[0] eq '0';
is X3D::Parse::Concept::parse('b : a {0}')->{body}->[0],   '0';
is X3D::Parse::Concept::parse('b : a {0 }')->{body}->[0],  '0';
is X3D::Parse::Concept::parse('b : a { 0 }')->{body}->[0], '0';
is X3D::Parse::Concept::parse('b : a { 0}')->{body}->[0],  '0';

is X3D::Parse::Concept::parse('b : a { 0 0}')->{body}->[0],  '0 0';
is X3D::Parse::Concept::parse('b : a { 0 0 }')->{body}->[0], '0 0';
is X3D::Parse::Concept::parse('b : a {0 0 }')->{body}->[0],  '0 0';
is X3D::Parse::Concept::parse("b : a {0 0 }")->{body}->[0],  "0 0";
is X3D::Parse::Concept::parse("b : a {0 0 0}")->{body}->[0], "0 0 0";
is X3D::Parse::Concept::parse("b : a {1 2 3}")->{body}->[0], "1 2 3";

is X3D::Parse::Concept::parse( "b : a {
0 0 0
}" )->{body}->[0], "0 0 0";

is X3D::Parse::Concept::parse( "b : a {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}" )->{body}->[0],
  "SFNode [in,out] metadata NULL [X3DMetadataObject]";

is X3D::Parse::Concept::parse( '
Anchor : X3DGroupingNode { 
  MFNode   [in]     addChildren
  MFNode   [in]     removeChildren
  MFNode   [in,out] children       []       [X3DChildNode]
  SFString [in,out] description    ""
  SFNode   [in,out] metadata       NULL     [X3DMetadataObject]
  MFString [in,out] parameter      []
  MFString [in,out] url            []       [url or urn]
  SFVec3f  []       bboxCenter     0 0 0    (-\u221e,\u221e)
  SFVec3f  []       bboxSize       -1 -1 -1 [0,\u221e) or \u22121 \u22121 \u22121 
}
')->{body}->[8],
  'SFVec3f  []       bboxSize       -1 -1 -1 [0,\u221e) or \u22121 \u22121 \u22121';

__END__

ok X3D::Parse::Concept::parse 'X3DNode{}';
X3D::Parse::Concept::parse 'X3DNode { }';

X3D::Parse::Concept::parse '
X3DNode {
  SFNode [in,out] metadata NULL [X3DMetadataObject]
}
';

