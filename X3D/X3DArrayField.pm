 package X3DArrayField;
use strict;
use warnings;
no strict 'refs';

BEGIN {
	use rlib "./";

	use X3DGenerator;
	use Attribute::Overload;
	use Array;

	use overload
	  "<=>" => \&Array::ncmp,
	  "=="  => sub { !( $_[0] <=> $_[1] ) },
	  "!="  => sub { ( $_[0] <=> $_[1] ) && 1 },
	  '""'  => sub { $_[0]->toString },
	  ;
}

our $SField;

sub new {
	my $self = shift;
	my $class = ref($self) || $self;
	
	my $value = @_ == 1 && ref($_[0]) eq 'ARRAY' ? shift : [];

	tie my (@this), $class, $value;
	my $this = bless \@this, $class;

	push @$this, @_;

	return $this;
}

sub TIEARRAY { bless \$_[1], $_[0] }

sub FETCHSIZE { scalar @${ $_[0] } }

sub STORESIZE {
	my $SField = ${ ref( $_[0] ) . "::SField" };
	for ( my $i = @${ $_[0] } ; @${ $_[0] } < $_[1] ; ++$i ) {
		${ $_[0] }->[$i] = $SField->new;
	}
}

sub STORE {
	${ $_[0] }->[ $_[1] ] = ${ ref( $_[0] ) . "::SField" }->new( ref $_[2] ? $_[2]->getValue : $_[2] );
}
sub FETCH { ${ $_[0] }->[ $_[1] ] }

sub CLEAR { @${ $_[0] } = () }
sub POP { pop( @${ $_[0] } ) }

sub PUSH {
	my $o      = shift;
	my $SField = ${ ref($o) . "::SField" };
	push( @$$o, map { $SField->new($_) } @_ );
}
sub SHIFT { shift( @${ $_[0] } ) }

sub UNSHIFT {
	my $o      = shift;
	my $SField = ${ ref($o) . "::SField" };
	unshift( @$$o, map { $SField->new($_) } @_ );
}
sub EXTEND { $_[0]->STORESIZE( $_[1] ) }
sub EXISTS { exists ${ $_[0] }->[ $_[1] ] }
sub DELETE { delete ${ $_[0] }->[ $_[1] ] }

sub SPLICE {
	my $ob  = shift;
	my $sz  = $ob->FETCHSIZE;
	my $off = @_ ? shift: 0;
	$off += $sz if $off < 0;
	my $len = @_ ? shift: $sz - $off;
	my $SField = ${ ref($ob) . "::SField" };
	return splice( @$$ob, $off, $len, map { $SField->new($_) } @_ );
}

sub copy : Overload(=) {
	$_[0]->new( $_[0]->getValue );
}

sub getValue { map { $_->getValue } @{ $_[0] } }

sub get1Value { $_[0]->[ $_[1] ] }

sub setValue {
	my $this = shift;
	@$this = @_;
	return;
}

sub set1Value { $_[0]->[ $_[1] ] = $_[2] }

sub length : Overload(0+) {
	my $this = shift;
	$#$this = $_[0] - 1 if @_;
	return scalar @$this;
}

sub toString {
	my $this = CORE::shift;

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
