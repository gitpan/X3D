package X3DObject;
use strict;
no strict 'refs';
use warnings;

use rlib "./";

use X3DError;

use base qw(X3DBase);

use overload
  "=="   => sub { $_[0]->getId == $_[1] },
  "!="   => sub { $_[0]->getId != $_[1] },
  'bool' => sub { 1 },
  '""'   => sub { $_[0]->toString };

sub create {    #X3DError::Debug ref $_[0];
	my $this = shift;
	$this->{name}     = shift || "";
	$this->{comments} = shift if @_;
}

sub setName { $_[0]->{name} = $_[1] }    #*
sub getName { $_[0]->{name} }

sub toString { sprintf "%s", $_[0]->getType }

sub dispose {
	my $this = shift;
	%$this = ();
}

1;

__END__
