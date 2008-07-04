package X3D::Hash;

our $VERSION = '0.009';

use X3D::Package 'X3DHash { }', 'isHash';


use overload
  'bool' => 'getSize',

  '0+'  => 'getSize',
  'int' => 'getSize',
  #  '<=>' => sub { warn },
  #  'cmp' => sub { warn },

  '@{}' => 'getValues',
  ;

sub new {
	my $self = $_[0];
	my $type = ref($self) || $self;
	return bless $_[1] || {}, $type;
}

sub getClone {
	my $clone = $_[0]->new;
	%$clone = %{ $_[0] };
	return $clone;
}

sub getKeys   { new X3D::Array [ keys( %{ $_[0] } ) ] }
sub getValues { new X3D::Array [ values( %{ $_[0] } ) ] }

sub getSize { scalar keys %{ $_[0] } }

sub isHash {
	UNIVERSAL::isa( $_[0], __PACKAGE__ )
	  or
	  UNIVERSAL::isa( $_[0], 'HASH' )
}

sub clear { %{ $_[0] } = () }

sub toString {
	my $this = shift;

	my $string = "";

	$string .= X3DGenerator->open_brace;

	if (%$this) {
		$string .= X3DGenerator->tidy_break;
		X3DGenerator->inc;
		while ( my ( $key, $value ) = each %$this ) {
			$string .= X3DGenerator->indent;
			$string .= $key;
			$string .= X3DGenerator->space;
			$string .= '=>';
			$string .= X3DGenerator->space;
			$string .= "$value";
			$string .= X3DGenerator->tidy_break;
		}
		X3DGenerator->dec;
		$string .= X3DGenerator->indent;
	} else {
		$string .= X3DGenerator->tidy_space;
	}

	$string .= X3DGenerator->close_brace;

	return $string;
}

#sub DESTROY {
#	my $this = shift;
#	%$this = ();
#	0;
#}

1;
__END__
