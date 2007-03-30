package X3DFieldDefinition;
use strict;
use warnings;

#use rlib "./";

use base qw(X3DField);

sub create {
	my $this = shift;
	@$this{ "accessType", "name", "value", "comment" } = @_;
}

sub getField {
	my ( $this, $parent ) = @_;
	my $field = new X3DField( $this->{accessType}, $this->{name}, $this->{value}->copy );
	$field->addParents($parent);
	return $field;
}

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
