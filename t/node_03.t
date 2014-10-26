#!/usr/bin/perl -w
#package node_03
use Test::More no_plan;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
	use_ok 'X3D';
}

ok my $node1 = new X3DBaseNode;
ok $node1->isa("UNIVERSAL");
ok $node1->isa("X3D::Universal");
ok $node1->isa("X3DUniversal");
ok $node1->isa("X3D::Object");
ok $node1->isa("X3DObject");
ok $node1->isa("X3DBaseNode");

printf "isa %s\n", join ", ", $node1->X3DPackage::Array("ISA");
printf "isa %s\n", join ", ", X3DBaseNode->X3DPackage::Array("ISA");
printf "isa %s\n", join ", ", @X3DBaseNode::ISA;
printf "isa %s\n", join ", ", @X3D::BaseNode::ISA;

printf "\n";
printf "%s\n", join ", ", @{ $node1->getHierarchy };

isa_ok $node1, $_ foreach @{ $node1->getHierarchy };

is join( ", ", @{ $node1->getHierarchy } ), "X3DBaseNode, X3DObject, X3DUniversal"; # 8
print map { "ISA:  $_\n" } @{ $node1->X3DPackage::getPath };
print map { "Super:  $_\n" } ref $node1;
ok $node1->isa("X3DBaseNode");

is $node1->X3DPackage::getSupertype, "X3D::BaseNode";

printf "\n";
can_ok $node1, qw'
  getId
  getType
  getTypeName
  getName
  ';

#printf "*** %s\n", join ", ", $_ foreach @{ $node1->getFieldDefinitions };

ok $node1->getId;
is $node1->getType,     'X3DBaseNode';
is $node1->getTypeName, 'X3DBaseNode';
ok $node1->getName =~ /^_\d+/;

printf "\n";
printf "%s\n", $node1->getId;
printf "%s\n", $node1->getType;
printf "%s\n", $node1->getTypeName;
printf "%s\n", $node1->getName;
printf "%s\n", $node1;

ok $node1->getName =~ /^_\d+/;
ok $node1->getName !~ /Texture$/o;

ok my $node2 = new X3DBaseNode("nodeName");

ok $node2->getId;
is $node2->getType,     'X3DBaseNode';
is $node2->getTypeName, 'X3DBaseNode';
ok $node2->getName =~  /^nodeName/;

printf "%s\n", $node2->getId;
printf "%s\n", $node2->getType;
printf "%s\n", $node2->getTypeName;
printf "%s\n", $node2->getName;
printf "%s\n", $node2;

ok $node2->getName =~  /^nodeName/;

#ok $node2->VERSION;

__END__

