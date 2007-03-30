# NOTE: Derived from SFNode.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package SFNode;

#line 74 "SFNode.pm (autosplit into auto/SFNode/copy.al)"
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

1;
# end of SFNode::copy
