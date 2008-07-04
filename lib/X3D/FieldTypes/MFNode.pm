package X3D::FieldTypes::MFNode;

our $VERSION = '0.012';

use X3D::Package 'MFNode : X3DArrayField { [] }';

use X3D::Tie::Value::BaseNodeArray;

sub create {
   my ($this) = @_;

   $this->{value} = $this->getInitialValue->getClone;
   $this->{array} = new X3D::Tie::Value::BaseNodeArray $this;

   tie $this->{length}, 'X3D::Tie::ArrayLength', $this->{array};

   return;
}

sub toString {
   my $this = shift;

   my $string = '';

   my $value = [ grep { $_ } @{ $this->getValue } ];

   if (@$value) {
      if ($#$value) {
         $string .= X3DGenerator->open_bracket;
         X3DGenerator->inc;
         $string .= X3DGenerator->tidy_break;
         $string .= X3DGenerator->indent;
         $string .= join X3DGenerator->tidy_break . X3DGenerator->indent, @$value;
         X3DGenerator->dec;
         $string .= X3DGenerator->tidy_break;
         $string .= X3DGenerator->indent;
         $string .= X3DGenerator->close_bracket;
      }
      else {
         $string .= $value->[0];
      }
   }
   else {
      $string .= X3DGenerator->open_bracket;
      $string .= X3DGenerator->tidy_space;
      $string .= X3DGenerator->close_bracket;
   }

   return $string;
}

sub dispose {    # X3DMessage->Debug();
   my ( $this, $nodeToDispose ) = @_;

   if ( $this->getParents ) {
      foreach ( @{ $this->getParents } ) {
         return 1 if $_->dispose($nodeToDispose);
      }
		return 0;
   }

   return 1;
}

sub DESTROY {
   my $this = shift;
   $this->setValue( [] );
	return;
}

1;
__END__
