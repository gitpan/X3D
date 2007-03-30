package X3DField;
use strict;
use warnings;
#no strict 'refs';

#use rlib "./";

use base qw(X3DObject);

use X3DConstants;
use X3DFieldTypes;
use X3DGenerator;

sub create {
	my $this = shift;
	@$this{ "accessType", "name", "value", "comment" } = @_;
	$this->{update}         = FALSE;
	$this->{callbacks}      = {};
	$this->{fieldCallbacks} = {};

	$this->{value}->addParents($this) if $this->{value}->can("addParents");
}

sub copy {
	my $this = shift;
	$this->new( @$this{ "accessType", "name", "value", "comment" } );
}

sub getAccessType { $_[0]->{accessType} }

sub isWritable { $_[0]->{accessType} & outputOnly }
sub isReadable { $_[0]->{accessType} ^ inputOnly }

sub getType { ref $_[0]->{value} }

sub getParent { ( $_[0]->getParents )[0] }

sub getValue { $_[0]->{value} }
#sub get1Value { $_[0]->{value}->[ $_[1] ] }

sub setValue {
	my ( $this, $value ) = @_;
	#X3DError::Debug ref $value;

	$this->{update} = TRUE;
	$this->{value}->setValue( ref $value ? $value->getValue : $value );
}
#sub set1Value { $_[0]->{value}->[ $_[1] ] = $_[2] }

#registerFieldInterest
# $field->addFieldCallback("callback", $node);
sub addFieldCallback {    #X3DError::Debug;
	my ( $this, $callbackName, $object ) = @_;

	my $callback = $object->can($callbackName);
	return $this->{callbacks}->{ X3DUniversal::getId($object) . $callbackName } =
	  [ $callback, $object ]
	  if ref $callback;

	return $this->{fieldCallbacks}->{ X3DUniversal::getId($object) . $callbackName } =
	  [ $object, $callbackName ]
	  if $object->isa("SFNode")
	  and ref $object->getValue->getField($callbackName);

	return;
}

sub removeFieldCallback {
	my ( $this, $callbackName, $object ) = @_;
	delete $this->{callbacks}->{ X3DUniversal::getId($object) . $callbackName };
	#delete $this->{fieldCallbacks}->{ X3DUniversal::getId($object) . $callbackName };
	return;
}

sub processEvent {    #X3DError::Debug;
	my ($this) = @_;
	return unless $this->{update};

	#### fieldCallbacks
	$_->[0]->getValue->getField( $_->[1] )->setValue( $this->{value} )
	  foreach values %{ $this->{fieldCallbacks} };

	$_->[0]->getValue->processEvents foreach values %{ $this->{fieldCallbacks} };

	#### callbacks
	&{ $_->[0] }( $_->[1], $this->{value} ) foreach values %{ $this->{callbacks} };

	$this->{update} = FALSE;
	return;
}

sub toString {
	my $this   = shift;
	my $string = "";

	$string .= $this->{name};
	$string .= $X3DGenerator::SPACE;
	$string .= $this->{value}->isa("SFString") ? "\"$this->{value}\"" : $this->{value};

	if ( $this->{comment} ) {
		$string .= $X3DGenerator::TAB;
		$string .= "#";
		$string .= $this->{comment};
	}

	return $string;
}

1;
__END__
