#!/usr/bin/perl -w
#package dispose_01
use Test::More no_plan;
use strict;

BEGIN {
   $| = 1;
   chdir 't' if -d 't';
   unshift @INC, '../lib';
   use_ok 'X3D';
}

use X3D::Package 'TestNode : X3DBaseNode {
	SFNode		[in,out] sfnode	   NULL
	SFNode		[in,out] sfnode2	   NULL
	MFNode		[in,out] mfnode	   []
}
';

{
   print "###########################################################";
   ok my $testNode = new SFNode( new TestNode('TestNode1') );
   {
      my $node2 = new SFNode( new TestNode('TestNode2') );
      $testNode->sfnode = $node2;
      $node2->sfnode    = $testNode;
	   print $testNode;
   }
	print $testNode;
	
	print "###########################################################";
}
print "###########################################################";
{
   print "###########################################################";
   ok my $testNode = new SFNode( new TestNode('TestName3') );
   {
      my $node2 = new SFNode( new TestNode('node2') );
      $testNode->mfnode = $node2;
      $node2->mfnode    = $testNode;
   }
   print "###########################################################";
}
print "###########################################################";

{
   my $sfnode = new SFNode();
   {
      print "###########################################################";
      ok my $testNode = new SFNode( new TestNode('TestName') );
      {
         my $node2 = new SFNode( new TestNode('TestName') );
         $testNode->sfnode = $node2;
         $node2->sfnode    = $testNode;
         $node2->mfnode    = $testNode;
         $sfnode->setValue($node2);
      }
      print "###########################################################";
		ok $sfnode;
   }
   print "###########################################################";
	ok $sfnode;
	print $sfnode;
}
print "# BLOCK ##########################################################";
print ">>>END2";

{
	ok my $testNode = new SFNode( new TestNode('TestName3') );

	sub set_children3 {
		my ($this) = @_;

		$this->sfnode = $this;
		$this->mfnode = new TestNode('TestName4');
	}

	set_children3($testNode);

	is $testNode->getValue->getReferenceCount, 3;
}
print ">>>END3";

{
	ok my $testNode = new SFNode( new TestNode('TestName5') );
	$testNode->sfnode = new TestNode('TestName6');

	sub set_children4 {
		my ($this) = @_;

		$this->sfnode->sfnode = $this;
	}

	set_children4($testNode);

	is $testNode->getValue->getReferenceCount, 3;
}

print ">>>END3";

use X3D::Debug;

{
	ok my $testNode = new SFNode( new TestNode('TestName7') );
	$testNode->sfnode2 = new TestNode('TestName8');

	sub set_children5 {
		my ($this) = @_;

		$this->sfnode = $this;
		$this->sfnode2->mfnode = $this;
	}

	set_children5($testNode);
	
	is $testNode->getValue->getParents->getSize, 3;
	print $testNode;
	$testNode->sfnode = undef;
	is $testNode->getValue->getParents->getSize, 2;
	print $testNode;
	#$testNode->sfnode2->mfnode->length = 0;
	#is $testNode->sfnode2->mfnode->length, 0;
	#is $testNode->getValue->getReferenceCount, 2;
	print $testNode;
}

print ">>>END3";
END { print "# END ##########################################################"; }
__END__



{
	ok my $testNode = new SFNode( new TestNode('TestName9') );
	$testNode->mfnode = new TestNode('TestName10');
#	ok my $testNode2 = new SFNode( new TestNode('TestName10') );

	sub set_children6 {
		my ($this) = @_;

		$this->mfnode->[0]->mfnode2 = $this;
	}

	set_children6($testNode);

	is $testNode->getValue->getReferenceCount, 2;
	#print $testNode;
}

print ">>>END3";
__END__
ok $testNode->sfnode          = new SFNode( new TestNode('T11') );
