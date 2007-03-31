package SFNode;
use strict;
use warnings;

#use AutoSplit; autosplit('SFNode', './auto/', 0, 1, 1);

use rlib "../";

use base qw(SFScalar);

use X3DGenerator;
use X3DError;

use Hash::NoRef;

use AutoLoader;
our $AUTOLOAD;

sub AUTOLOAD {
	my $this = shift;

	my $node = $this->getValue;
	return warn unless ref $node;

	$X3DNode::AUTOLOAD = $AUTOLOAD;
	return $node->AUTOLOAD(@_);
}

use overload
  "=="   => sub { $_[1] == $_[0]->getValue },
  "!="   => sub { $_[1] != $_[0]->getValue },
  "bool" => sub { ref $_[0]->getValue },
  '""' => \&toString,
  ;

sub copy {
	my $this = shift;
	my $sfnode = $this->new( $this->{value} );
	return $sfnode;
}

sub setValue {
	my $this = shift;
	$this->{value} = shift || 0;
}

sub toString {    #X3DError::Debug;
	return $_[0]->getValue || $X3DGenerator::NULL;
}

1;
__END__

sub deepCopy { die "SFNode::deepCopy not implemented yet" }

sub copy {
	my $this = shift;
	my $copy = $this->new;
	$copy->setValue( $this->getValue ) if ref $this->getValue;
	return $copy;
}

use Benchmark qw(timethis);
my $h = {};
my $f = new SFNode($h);
$f->setValue($h);
my $n = new SFNode($h);
printf "%s\n", $f->getReferenceCount;
printf "%s\n", $n == $n;

#my $n = new SFNode(10);

#timethis 4000000,  sub { new SFNode({}) };
#timethis 2000000, sub { $f->setValue({}) };

