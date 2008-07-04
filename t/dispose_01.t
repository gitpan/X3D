#!/usr/bin/perl -w
#package dispose_01
use Test::More no_plan;
use strict;

BEGIN {
   $| = 1;
   chdir 't' if -d 't';
   unshift @INC, '../lib';
   use_ok 'X3D';
   use_ok 'TestNodeFields';
}

{
   ok my $testNode = new SFNode( new TestNode('TestName1') );

   sub set_child {
      my ( $this, $value ) = @_;

      $this->sfnode = $value;
      $this->mfnode = $value;
   }

   is $testNode->getValue->getReferenceCount, 2;

   set_child( $testNode, $testNode );

   is $testNode->getValue->getReferenceCount, 4;

   set_child( $testNode, undef );

   is $testNode->getValue->getReferenceCount, 2;
}

print ">>>END1";

{

   ok my $testNode = new SFNode( new TestNode('TestName2') );

   sub set_child2 {
      my ( $this, $value ) = @_;

      $this->sfnode = $value;
      $this->mfnode = $value;
   }

   set_child2( $testNode, $testNode );

   is $testNode->getValue->getReferenceCount, 4;
   ok $testNode->mfnode->[0] == $testNode;

   is $testNode->sfnode->getReferenceCount, 4;
   is $testNode->mfnode->[0]->getReferenceCount, 4;
   is $testNode->mfnode->[0]->getId,             $testNode->getValue->getId;

   my $node = $testNode->sfnode;
   ok $node->isa('TestNode');
   ok $node->isa('BaseNode');

}

{
   ok my $testNode = new SFNode( new TestNode('TestName3') );
   foreach ( 1 ... 10 ) {
      my $node2 = new SFNode( new TestNode('node2') );
      $testNode->sfnode = $node2;
      $testNode->mfnode = $node2;
   }
}

__END__


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
	$testNode->sfnode2 = new TestNode('TestName6');

	sub set_children4 {
		my ($this) = @_;

		$this->sfnode2->sfnode = $this;
	}

	set_children4($testNode);

	is $testNode->getValue->getReferenceCount, 3;
}

print ">>>END3";

{
	ok my $testNode = new SFNode( new TestNode('TestName7') );
	$testNode->sfnode2 = new TestNode('TestName8');

	sub set_children5 {
		my ($this) = @_;

		$this->sfnode = $this;
		$this->sfnode2->mfnode = $this;
	}

	set_children5($testNode);

	is $testNode->getValue->getReferenceCount, 3;
}

print ">>>END3";

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
