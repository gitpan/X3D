package X3D::BaseFieldTypes::Scalar;
use X3D::Perl;

our $VERSION = '0.009';

use overload

  #'=' => 'getClone', # defined in X3DField

  #'bool' => sub { $_[0]->getValue ? YES : NO }, # defined in X3DField
  '0+' => sub { 0 + $_[0]->getValue },

  '!' => sub { !$_[0]->getValue },

  '=='  => sub { $_[0]->getValue == $_[1] },
  '!='  => sub { $_[0]->getValue != $_[1] },
  '<=>' => sub { $_[2] ? $_[1] <=> $_[0]->getValue : $_[0]->getValue <=> $_[1] },

  #'>' => '_ngt',
  #'<' => '_nlt',
  #'>=' => '_nge',
  #'<=' => '_nle',

  'eq' => sub { $_[0]->getValue eq $_[1] },
  'ne' => sub { $_[0]->getValue ne $_[1] },
  'cmp' => sub { $_[2] ? $_[1] cmp $_[0]->getValue : $_[0]->getValue cmp $_[1] },

  #'gt' => '_gt',
  #'lt' => '_lt',
  #'ge' => '_ge',
  #'le' => '_le',

  '~' => sub { ~$_[0]->getValue },

  '&='  => sub { $_[0]->setValue( $_[0]->getValue & $_[1] );  $_[0] },
  '|='  => sub { $_[0]->setValue( $_[0]->getValue | $_[1] );  $_[0] },
  '^='  => sub { $_[0]->setValue( $_[0]->getValue ^ $_[1] );  $_[0] },
  '<<=' => sub { $_[0]->setValue( $_[0]->getValue << $_[1] ); $_[0] },
  '>>=' => sub { $_[0]->setValue( $_[0]->getValue >> $_[1] ); $_[0] },

  '&'  => sub { $_[0]->getValue & $_[1] },
  '|'  => sub { $_[0]->getValue | $_[1] },
  '^'  => sub { $_[0]->getValue ^ $_[1] },
  '<<' => sub { $_[2] ? $_[1] << $_[0]->getValue : $_[0]->getValue << $_[1] },
  '>>' => sub { $_[2] ? $_[1] >> $_[0]->getValue : $_[0]->getValue >> $_[1] },

  'neg' => sub { -$_[0]->getValue },

  '++' => sub { $_[0]->setValue( $_[0]->getValue + 1 ); $_[0] },
  '--' => sub { $_[0]->setValue( $_[0]->getValue - 1 ); $_[0] },

  '+=' => sub { $_[0]->setValue( $_[0]->getValue + $_[1] ); $_[0] },
  '-=' => sub { $_[0]->setValue( $_[0]->getValue - $_[1] ); $_[0] },

  '*='  => sub { $_[0]->setValue( $_[0]->getValue * $_[1] ); $_[0] },
  '/='  => sub { $_[0]->setValue( $_[0]->getValue / $_[1] ); $_[0] },
  '%='  => sub { $_[0]->setValue( $_[0]->getValue % $_[1] ); $_[0] },
  '**=' => sub { $_[0]->setValue( $_[0]->getValue**$_[1] );  $_[0] },

  #'.='  => '_dot',
  #'x='  => '_x',

  '+' => sub { $_[0]->getValue + $_[1] },
  '-' => sub { $_[2] ? $_[1] - $_[0]->getValue : $_[0]->getValue - $_[1] },

  '*'  => sub { $_[0]->getValue * $_[1] },
  '/'  => sub { $_[2] ? $_[1] / $_[0]->getValue : $_[0]->getValue / $_[1] },
  '%'  => sub { $_[2] ? $_[1] % $_[0]->getValue : $_[0]->getValue % $_[1] },
  '**' => sub { $_[2] ? $_[1]**$_[0]->getValue : $_[0]->getValue**$_[1] },

  #'.'  => 'dot',
  #'x'  => 'x',

  'int' => sub { int $_[0]->getValue },
  'abs' => sub { abs $_[0]->getValue },

  'cos' => sub { cos $_[0]->getValue },
  'sin' => sub { sin $_[0]->getValue },

  'exp' => sub { exp $_[0]->getValue },
  'log' => sub { log $_[0]->getValue },

  'sqrt' => sub { sqrt $_[0]->getValue },

  'atan2' => sub { $_[2] ? atan2( $_[1], $_[0]->getValue ) : atan2( $_[0]->getValue, $_[1] ) },

  #'<>'

  #'${}'
  # '@{}' => sub  { X3DMessage->NotAnArrayReference(2, @_) },
  # '%{}', '&{}', '*{}'.

  #'nomethod', 'fallback',

  #'""' => 'toString', # definded in X3DUniversal

  #fallback => 1,
  ;

sub create {
   my ($this) = @_;
   $this->{value} = $this->getInitialValue;
   return;
}

1;
__END__
