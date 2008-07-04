package X3D::BaseNode;
use X3D::Perl;

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

   $package->X3DPackage::Glob( $_->getName ) = $_->createFieldClosure($package) foreach @$fieldDefinitions;

   return;
}

use X3D::Package 'X3DBaseNode : X3DObject { }';

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

   $copy->getField( $_->getName )->setValue( $_->getValue ) foreach @{ $this->getFields };

   return $copy;
}

sub getCopy { $_[0]->getClone }    # should make a deep copy

sub getTypeName { $_[0]->getType }

sub setName { $_[0]->{name} = $_[1] || '' }
sub getName { $_[0]->{name} }

# Fields
sub setFields { $_[0]->{fields} = $_[1] }
sub getFields { $_[0]->{fields} }

sub getField { $_[0]->getFields->getField( $_[1], $_[0] ) }

sub getFieldDefinitions { $_[0]->X3DPackage::Scalar("X3DFieldDefinitions") }

# Basenode
sub toString {
   my ($this) = @_;

   my $string = "";

   if ( X3DGenerator->isClone($this) ) {
      $string .= X3DGenerator->USE;
      $string .= X3DGenerator->space;
      $string .= X3DGenerator->getName($this);
      return $string;
   }

   X3DGenerator->registerNode($this);

   if ( X3DGenerator->getName($this) ) {
      $string .= X3DGenerator->DEF;
      $string .= X3DGenerator->space;
      $string .= X3DGenerator->getName($this);
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

   X3DGenerator->unregisterNode($this);

   return $string;
}

sub dispose {
   my ( $this, $nodeToDispose ) = @_;

   if ( ref $nodeToDispose && $this == $nodeToDispose ) {
      return 0;
   }

   if ( $this->getParents ) {
      foreach ( @{ $this->getParents } ) {
         return 1 if $_->dispose( ref $nodeToDispose ? $nodeToDispose : $this );
      }

      X3DMessage->Debug( $_[0], 0 );

      foreach ( @{ $this->getFields } ) {
         if ( $_->isa("MFNode") ) {
            $_->setValue( [] );
            next;
         }
         $_->setValue(undef)
           if $_->isa("SFNode");
      }

      return 1;
   }

   return 1;
}

#sub DESTROY {
#   X3DMessage->Debug( $_[0] );
#   return;
#}

1;
__END__
Scalar::Quote 

*{"${callpkg}::$sym"} =
	    $type eq '&' ? \&{"${pkg}::$sym"}
