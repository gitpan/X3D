package X3D::BaseNode;
use X3D;

our $VERSION = '0.015';

use X3D::Parse::FieldDescription;

sub SET_DESCRIPTION {
	my ( $this, $description ) = @_;
	my $fieldDescriptions = X3D::Parse::FieldDescription::parse @{ $description->{body} };
	my $fieldDefinitions = [ map { new X3DFieldDefinition(@$_) } @$fieldDescriptions ];
	$this->setFieldDefinitions($fieldDefinitions);
}

sub setFieldDefinitions {
	my ( $this, $fieldDefinitions ) = @_;
	my $package = $this->X3DPackage::getName;

	$this->X3DPackage::Scalar("X3DFieldDefinitions") = $fieldDefinitions;

	$package->X3DPackage::Glob( $_->getName ) = $_->createFieldClosure($package)
	  foreach @$fieldDefinitions;

	return;
}

use X3D 'X3DBaseNode : X3DObject { }';

sub new {
	my $this = shift->X3DObject::new;
	my $name = shift;

	$this->setName($name);

	$this->setFields( new X3DFieldSet( $this->getFieldDefinitions, $this ) );

	return $this;
}

sub getClone {
	my $this = shift;
	my $copy = $this->new( $this->getName );

	$copy->getField( $_->getName )->setValue( $_->getValue )
	  foreach @{ $this->getFields };

	return $copy;
}

sub getCopy { $_[0]->getClone }    # should make a deep copy

sub getTypeName { $_[0]->getType }

sub setName { $_[0]->{name} = new X3DName( $_[1] ) }
sub getName { $_[0]->{name}->toString }

# Fields
sub setFields { $_[0]->{fields} = $_[1] }
sub getFields { $_[0]->{fields} }

sub getField { $_[0]->getFields->getField( $_[1], $_[0] ) }

sub getFieldDefinitions { $_[0]->X3DPackage::Scalar("X3DFieldDefinitions") }

# Basenode
sub toString {
	my ($this) = @_;

	my $string = "";

	if ( $this->getName ) {
		$string .= X3DGenerator->DEF;
		$string .= X3DGenerator->space;
		$string .= $this->getName;
		$string .= X3DGenerator->space;
	}

	$string .= $this->getTypeName;
	$string .= X3DGenerator->tidy_space;

	if ( @{ $this->getComments } ) {
		$string .= X3DGenerator->tidy_break;
		X3DGenerator->inc;
		foreach ( $this->getComments ) {
			$string .= X3DGenerator->indent;
			$string .= X3DGenerator->comment;
			$string .= $_;
			$string .= X3DGenerator->tidy_break;
		}
		X3DGenerator->dec;
		$string .= X3DGenerator->indent;
	}

	$string .= $this->getFields;

	return $string;
}

#sub DESTROY {
#	my $this = shift;
#print "BaseNode::DESTROY";
#print "BaseNode::DESTROY ", $this->getName;
#printf "BaseNode::DESTROY: %d\n", $this->getReferenceCount;
#print  "BaseNode::Clones:  ", $this->{clones};
#}

sub DESTROY {
	# X3DMessage->Debug( $_[0] );
	return;
}

1;
__END__
	#printf "BaseNode::dispose: %s, %d\n", $node->getName, $node->{clones};
Scalar::Quote 

*{"${callpkg}::$sym"} =
	    $type eq '&' ? \&{"${pkg}::$sym"}
