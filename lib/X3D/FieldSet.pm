package X3D::FieldSet;

use X3D::Package 'X3DFieldSet : X3DArrayHash ()';

our $VERSION = '0.006';

use X3D::Tie::Field;
use X3D::Debug;

sub new {
   my ( $self, $fieldDefinitions, $parent ) = @_;

   my @fields;
   my %fields;
   my %tiedFields;

   for ( my $i = 0 ; $i < @$fieldDefinitions ; $i++ ) {
      my $fieldDefinition = $fieldDefinitions->[$i];
      my $name            = $fieldDefinition->getName;
      my $field           = $fieldDefinition->createField($parent);

      $fields[$i] = $field;
      $fields{$name} = $field;

      tie $tiedFields{$name}, 'X3D::Tie::Field', $field;

      # bug 44217; make perl know that this is a ref:
      # the tied scalar has to be 'touched' so perl knows
      # the content is a reference to a scalar
      # this can be done with either scalar(tiedField) or ref(tiedField) or an assignment
      # it sets these flags and states:
		# FLAGS = (...,ROK,OVERLOAD)
      # RV = (eg.) 0x8fd990
      # PV = (eg.) 0x8fd990 ""
      # CUR = 0
      # LEN = 0

      # ref scalar $tiedFields{$name};
      scalar $tiedFields{$name};
  }

   my $this = $self->X3DArrayHash::new( \@fields, \%fields );
   $$this->{tiedFields} = new X3DHash \%tiedFields;

   return $this;
}

sub getField : lvalue {
   my ( $this, $name ) = @_;

   X3DMessage->UnknownField( 2, @_[ 2, 1 ] ), return
     unless exists $this->{$name};

   $this->{$name};
}

sub getTiedField : lvalue {
   my ( $this, $name ) = @_;

   X3DMessage->UnknownField( 2, @_[ 2, 1 ] ), return
     unless exists $this->{$name};

   $$this->{tiedFields}->{$name};
}

sub getPrintableFields {
   my ( $this, $tidy ) = @_;
   my $fields = [];

   foreach (@$this) {
      my $fieldDefiniton = $_->getDefinition;

      push @$fields, $_
        unless ( $fieldDefiniton->isIn ^ $fieldDefiniton->isOut )
        || ( $tidy && ( $fieldDefiniton eq $_ ) );
   }

   return $fields;
}

sub toString {
   my ($this) = @_;

   my $fields = $this->getPrintableFields( X3DGenerator->getTidyFields );

   my $string = "";

   $string .= X3DGenerator->open_brace;

   if (@$fields) {
      $string .= X3DGenerator->tidy_break;
      X3DGenerator->inc;
      foreach (@$fields) {
         $string .= X3DGenerator->indent;
         $string .= $_->getName;
         $string .= X3DGenerator->space;
         $string .= $_;
         $string .= X3DGenerator->tidy_break;
      }
      X3DGenerator->dec;
      $string .= X3DGenerator->indent;
   }
   else {
      $string .= X3DGenerator->tidy_space;
   }

   $string .= X3DGenerator->close_brace;

   return $string;
}

1;
__END__
