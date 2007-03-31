package X3DObject;
use strict;
no strict 'refs';
use warnings;

use rlib "./";

use X3DError;

use base qw(X3DUniversal);

use overload
  "=="   => sub { $_[1] == $_[0]->getId },
  "!="   => sub { $_[1] != $_[0]->getId },
  'bool' => sub { 1 },
  '""'   => sub { $_[0]->toString };

sub new {
	my $self = shift;
	return $self->SUPER::new( {}, @_ );
}

sub create {    #X3DError::Debug ref $_[0];
	my $this = shift;
	$this->{comments} = [];
	$this->{name} = shift || "";
}

sub getType { ref $_[0] }

sub setName { $_[0]->{name} = $_[1] }    #*
sub getName { $_[0]->{name} }

#
sub addComments {
	my $this = shift;
	push @{ $this->{comments} }, @_;
}

sub getComments { @{ (shift)->{comments} } }

sub setComments {
	my $this = shift;
	@{ $this->{comments} } = @_;
}

sub toString { sprintf "%s", $_[0]->getType }

sub dispose {
	my $this = shift;
	#X3DError::Debug ref $this, $this->getType;
	%$this = ();
}
1;
__END__
