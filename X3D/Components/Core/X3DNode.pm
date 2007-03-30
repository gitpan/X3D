package X3DNode;
use strict;
use warnings;

#use AutoSplit; autosplit('X3DNode', './auto/', 0, 1, 1);

use rlib "../../";

use base qw(X3DObject);

use X3DConstants;
use X3DFieldDefinition;

our $FieldDefinitions =
  [ new X3DFieldDefinition( inputOutput, 'metadata', NULL, 'X3DMetadataObject' ) ];

use AutoLoader;
our $AUTOLOAD;

sub AUTOLOAD {
	my $this = shift;
	my $name = substr $AUTOLOAD, rindex( $AUTOLOAD, ':' ) + 1;

	#X3DError::Debug $name;
	my $field = $this->getField($name);
	return unless ref $field;

	return $field->setValue(@_) if @_;
	return $field->getValue;
}

sub create {    #X3DError::Debug ref $_[0];
	my $this = shift;

	$this->{browser} = undef;
	$this->{fields}  = {};

	foreach ( $this->getFieldDefinitions ) {
		my $name  = $_->getName;
		my $field = $_->getField($this);
		$field->addParents($this);
		$field->addFieldCallback( "_$name", $this ) if $this->can("_$name");
		$this->{fields}->{$name} = $field;
	}
}

sub copy { shift }

sub setBrowser { $_[0]->{browser} = $_[1] }
sub getBrowser { $_[0]->{browser} }

sub getTypeName { $_[0]->getType }

sub getField {
	my ( $this, $name ) = @_;
	return X3DError::UnknownField $this, $name unless exists $this->{fields}->{$name};
	return $this->{fields}->{$name};
}

sub getFieldDefinitions { $_[0]->get_class_variable("FieldDefinitions") }

#sub setFields {
#	my ( $this, $fields ) = @_;
#	return;
#}

sub getFields {
	my ( $this, $all ) = @_;
	my $fields = [];

	foreach ( $this->getFieldDefinitions ) {
		push @$fields, $this->{fields}->{ $_->getName }
		  if ( $_->getAccessType == inputOutput || $_->getAccessType == initializeOnly )
		  && ( $_->getValue != $this->{fields}->{ $_->getName }->getValue || $all );
	}

	return wantarray ? @$fields : $fields;
}

sub processEvents {    #X3DError::Debug;
	my ($this) = @_;
	my $time = time;

	$this->call("prepareEvents");

	foreach ( map { $_->getName } $this->getFieldDefinitions ) {
		$this->{fields}->{$_}->processEvent($time);
	}

	$this->call("eventsProcessed");
	return;
}

sub toString {
	my $this   = shift;
	my $string = "";

	if ( $this->{name} ) {
		$string .= "DEF";
		$string .= $X3DGenerator::SPACE;
		$string .= $this->{name};
		$string .= $X3DGenerator::SPACE;
	}

	$string .= $this->getTypeName;
	$string .= $X3DGenerator::TSPACE;
	$string .= "{";

	if ( @{ $this->{comments} } ) {
		$string .= $X3DGenerator::TBREAK;
		X3DGenerator::INC_INDENT;
		foreach ( @{ $this->{comments} } ) {
			$string .= $X3DGenerator::INDENT;
			$string .= "#";
			$string .= $_;
			$string .= $X3DGenerator::TBREAK;
		}
		X3DGenerator::DEC_INDENT;
		$string .= $X3DGenerator::INDENT;
	}

	my $fields = $this->getFields($X3DGenerator::AllFields);
	if (@$fields) {
		$string .= $X3DGenerator::TBREAK;
		X3DGenerator::INC_INDENT;
		foreach (@$fields) {
			$string .= $X3DGenerator::INDENT;
			$string .= $_;
			$string .= $X3DGenerator::TBREAK;
		}
		X3DGenerator::DEC_INDENT;
		$string .= $X3DGenerator::INDENT;
	}

	$string .= "}";

	return $string;
}

sub dispose {
	my $this = shift;
	$this->call("shutdown");
}

1;
__END__
printf "%s\n", __PACKAGE__->new;

__DATA__
Creation phase
Setup phase
	setBrowser
	setFields
	initialize
Realized phase
	prepareEvents
	eventsProcessed
Disposed phase
	shutdown

