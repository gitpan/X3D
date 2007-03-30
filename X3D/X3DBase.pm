package X3DBase;
use strict;
no strict 'refs';
use warnings;

use rlib "./";

use base qw(X3DUniversal);

sub new {
	my $self = shift;
	return $self->SUPER::new({}, @_);
}

sub create {
	my $this = shift;
	$this->{parents}  = [];
	$this->{comments} = [];
}

sub getId { X3DUniversal::getId(shift) }

sub getType { ref $_[0] }

sub addParents {
	my ( $this, @parents ) = @_;
	push @{ $_[0]->{parents} }, @parents;
}

sub removeParents {
	my ( $this, @parents ) = @_;
}

sub getParents {
	my $this    = shift;
	my $parents = $this->{parents};

	return @$parents     if wantarray;
	return $parents->[0] if @$parents;
}

sub addComments { push @{ (shift)->{comments} }, @_ }
sub getComments { @{ (shift)->{comments} } }
sub setComments { @{ (shift)->{comments} } = @_ }

1;

#printf "%s\n", __PACKAGE__->new;
__END__
