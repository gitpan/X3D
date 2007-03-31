package TieArray;
use strict;
use warnings;
no strict 'refs';

use rlib "../";

use X3DError;

# subs für $this->{value}
sub TIEARRAY {
	my ( $class, $array ) = @_;
	bless $array, $class;
}

sub FETCHSIZE {
	my $array = shift;
	$#$array;
}

sub STORESIZE {
	my $array = shift;
	my $index = shift;
	my $size  = shift;
	my $this  = $array->[0];

	$index++;

	my $SField = ${ ref($this) . "::SField" };

	for ( my $i = @$array ; @$array < $index ; ++$i ) {
		$array->[$i] = $SField->new;
	}
}

#
sub STORE {
	my $array = shift;
	my $index = shift;
	my $value = shift;
	my $this  = $array->[0];

	my $SField = ${ ref($this) . "::SField" };

	$value = ref $value ? $value->copy : $SField->new($value);

	$array->[ $index + 1 ] = $value;
}

#
sub FETCH { $_[0]->[ $_[1] + 1 ] } #sub FETCH { ${ $_[0] }->[ $_[1] ]->copy }!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

#
sub CLEAR {
	my $array = shift;
	my $this  = shift @$array;
	@$array = ($this);
}

#
sub SHIFT { $_[0]->SPLICE( 0, 1 ) }

sub PUSH {
	my $array = shift;
	$array->SPLICE( $#$array, 0, @_ )
}

sub POP { $_[0]->SPLICE( 0, -1 ) }

#
sub UNSHIFT {
	my $array = shift;
	$array->SPLICE( 0, 0, @_ )
}

sub EXTEND { $_[0]->STORESIZE( $_[1] ) }
sub EXISTS { exists $_[0]->[ $_[1] + 1 ] }
sub DELETE { delete $_[0]->[ $_[1] + 1 ] }

sub SPLICE {
	my $array = shift;
	my $this  = $array->[0];

	my $size = $array->FETCHSIZE;

	my $offset = @_ ? shift: 0;
	$offset += $size if $offset < 0;

	my $length = @_ ? shift: $size - $offset;

	my @values = map { ref $_ ? $_->copy : $_ } @_;

	@values = splice( @$array, $length >= 0 ? $offset + 1 : $offset, $length, @values );

	return @values;
}

sub DESTROY {    #X3DError::Debug ref $_[0];
	my $this = shift;
	$this->CLEAR;
	@$this = ();
	0;
}

1;

package MFScalar;
use strict;
use warnings;

use rlib "../";

use Scalar::Util;
use X3DGenerator;
use X3DError;
use Array;

use SFScalar;
our $SField = new SFScalar;

#use List::Util qw(first max maxstr min minstr reduce shuffle sum);

use overload
  "="   => \&copy,
  "<=>" => \&Array::ncmp,
  "=="  => sub { !( $_[0] <=> $_[1] ) },
  "!="  => sub { ( $_[0] <=> $_[1] ) && 1 },
  "0+"  => sub { $_[0]->length },
  '""'  => sub { $_[0]->toString },
  '@{}' => sub { $_[0]->{value} },
  ;

sub new {
	my $self  = shift;
	my $class = ref($self) || $self;

	my $this = bless {}, $class;
	$this->_create(@_);

	return $this;
}

sub _create {
	my $this = shift;

	my $value = @_ == 1 && ref( $_[0] ) eq 'ARRAY' ? shift: [@_];

	unshift @$value, $this;
	#X3DError::Debug ref $value->[0];

	tie my @array, "TieArray", $value;
	$this->{value} = \@array;

	#X3DError::Debug scalar @array;
}

sub getId { Scalar::Util::refaddr(shift) }

sub copy {
	$_[0]->new( $_[0]->getValue );
}

sub getValue { map { $_->copy } @{ $_[0] } }

sub get1Value { $_[0]->[ $_[1] ]->copy }

sub setValue {
	my $this = shift;
	@$this = @_;
	return;
}

sub set1Value { $_[0]->[ $_[1] ] = $_[2] }

sub getIndex { Array::index @_ }

sub length {
	my $this = shift;
	$#$this = $_[0] - 1 if @_;
	return scalar @$this;
}

sub toString {
	my $this = shift;

	return "[${X3DGenerator::TSPACE}]" unless @$this;

	my $string = '';
	if ($#$this) {
		$string .= "[${X3DGenerator::TSPACE}";
		$string .= join ",${X3DGenerator::TSPACE}", @$this;
		$string .= "${X3DGenerator::TSPACE}]";
	}
	else {
		$string .= $this->[0];
	}

	return $string;
}

1;
__END__

sub new {
	my $self  = CORE::shift;
	my $class = ref($self) || $self;
	my $this  = [];

	bless $this, $class;
	$this->setValue(@_);
	return $this;
}

sub copy : Overload(=) {
	my $this = shift;
	my $copy = $this->new($this->getValue);
	return $copy;
}

sub getValue {
	my $this = CORE::shift;
	return [@$this];
}

sub get1Value {
	my $this  = CORE::shift;
	my $index = CORE::shift;
	$this->length($index + 1) if $#{$this} < $index;
	return $this->[$index];
}

sub setValue {
	my $this = CORE::shift;
	if (@_) {
		if (ref $_[0] eq 'ARRAY') {
			$this->length(scalar @{$_[0]});

			for (my $i = 0; $i < @{$_[0]}; ++$i) {
				$this->[$i]->setValue($_[0]->[$i]->getValue);
			}
		} elsif (substr(ref $_[0], 0,2) eq 'MF') {
			$this->length(scalar @{$_[0]});

			for (my $i = 0; $i < @{$_[0]}; ++$i) {
				$this->[$i]->setValue($_[0]->[$i]->getValue);
			}
		} else {
			$this->length(scalar @_);

			for (my $i = 0; $i < @_; ++$i) {
				$this->[$i]->setValue($_[$i]);
			}
		}
	} else {
		@$this = ();
	}
	return;
}

sub set1Value {
	my $this  = CORE::shift;
	my $index = CORE::shift;
	my $value = CORE::shift;
	$this->length($index + 1) if $#$this < $index;
	$this->[$index]->setValue($value);
	return;
}

no strict 'refs';
sub length : Overload(0+) {
	my $this = CORE::shift;

	my $ref    = ref $this;
	my $length = @$this;

	if (@_) {
		my $length = CORE::shift;
		if ($length < @$this) {
			# decrease size
			@$this = splice(@$this, $length);
		} else {
			# increase size
			for (my $i = @$this; $i < $length; ++$i) {
				$this->[$i] = ${"${ref}::SField"}->new();
			}
		}
	}

	return scalar @$this;
}
use strict 'refs';

sub push  {
	my $this   = CORE::shift;
	my $mfield = CORE::shift;

	my $i      = $this->length;
	my $length = $i + $mfield->length;

	$this->length($length);

	for (; $i < $length; ++$i) {
		$this->[$i]->setValue($mfield->[$i]->getValue);
	}
}
