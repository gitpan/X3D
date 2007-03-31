package X3DFieldDefinition;
use strict;
use warnings;

use base qw(X3DObject);

use X3DField;

sub create {
	my $this = shift;
	@$this{ "accessType", "name", "value", "comment" } = @_;
}

sub getField {
	my ( $this, $node ) = @_;
	my $field = new X3DField( $node, $this->{accessType}, $this->{name}, $this->{value}->copy );
	return $field;
}

sub getAccessType { $_[0]->{accessType} }
sub getValue      { $_[0]->{value} }

sub toString {
	my $this   = shift;
	my $string = "";

	$string .= $X3DGenerator::AccessTypes->[ $this->getAccessType ];
	$string .= $X3DGenerator::SPACE;
	$string .= $this->getType;
	$string .= $X3DGenerator::SPACE;
	$string .= $this->SUPER::toString;

	return $string;
}

1;
__END__
