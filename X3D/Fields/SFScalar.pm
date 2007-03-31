package SFScalar;
use strict;
use warnings;
no strict 'refs';

use rlib "../";

use Scalar::Util;
use X3DGenerator;
use X3DError;

sub new {
	my $self = shift;
	my $class = ref($self) || $self;

	my $this = bless {}, $class;
	$this->setValue(@_);

	return $this;
}

sub getId { Scalar::Util::refaddr(shift) }

sub setValue {
	my $this = shift;
	$this->{value} = shift;
}

sub getValue { return (shift)->{value} }

sub getReferenceCount {
	my $this = shift;
	return Hash::NoRef::SvREFCNT( $this->{value} );
}

sub DESTROY {
	my $this = shift;
	0;
}

1;
__END__
