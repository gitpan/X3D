package X3DUniversal;
use strict;
no strict 'refs';
use warnings;

use rlib "./";

use Scalar::Util;
use Class::ISA;
use X3DError;
#use Scalar::Util::Clone qw(clone);

sub new {
	my $self = shift;
	my $type = shift;
	my $class = ref($self) || $self;

	my $this = bless $type, $class;
	$this->call( "create", @_ );

	return $this;
}

sub getId { Scalar::Util::refaddr(shift) }

sub call {
	my $this   = shift;
	my $method = shift;
	&$_( $this, @_ ) foreach $this->_get_methods($method);
	return;
}

sub rcall {
	my $this   = shift;
	my $method = shift;
	&$_( $this, @_ ) foreach reverse $this->_get_methods($method);
	return;
}

sub getHierarchy { reverse( Class::ISA::self_and_super_path( ref $_[0] ) ) }

sub get_class_variable {
	my ( $this, $name ) = @_;
	my $property = sprintf "%s::_%s", ref $this, $name;

	unless ( defined $$property ) {
		$$property = [];
		push @$$property, map { @${"${_}::${name}"} }
		  grep { defined ${"${_}::${name}"} } $this->getHierarchy;
	}

	wantarray ? @$$property : $$property;
}

sub _get_methods {
	my ( $this, $name ) = @_;
	my $property = sprintf "%s::_%s", ref $this, $name;

	unless ( defined $$property ) {
		$$property = [];
		push @$$property, map { \&{"${_}::${name}"} }
		  grep { exists &{"${_}::${name}"} } $this->getHierarchy;
	}

	wantarray ? @$$property : $$property;
}

sub DESTROY {    #X3DError::Debug ref $_[0];
	my $this = shift;
	return Scalar::Util::reftype($this) eq "REF";
	$this->call("dispose") if keys %$this;
	0;
}

1;

#printf "%s\n", __PACKAGE__->new;
__END__
