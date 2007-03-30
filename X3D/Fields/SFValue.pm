package SFValue;
use strict;
use warnings;
no strict 'refs';

use rlib "../";

use X3DGenerator;
use X3DError;

use base qw(X3DBase);

sub create {
	my $this = shift;
	$this->setValue(@_);
}

sub setValue {
	my $this = shift;
	$this->{value} = shift || 0;
}

sub getValue { return (shift)->{value} }

sub getReferenceCount {
	my $this = shift;
	return Hash::NoRef::SvREFCNT($this->{value});
}

1;
__END__
