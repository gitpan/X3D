package X3D::BaseFieldTypes::Scalar;

our $VERSION = '0.009';

use overload
  '0+' => sub { 0+ $_[0]->getValue },

  '!' => sub { !$_[0]->getValue },

  '=='  => sub { $_[0]->getValue == $_[1] },
  '!='  => sub { $_[0]->getValue != $_[1] },
  '<=>' => sub { $_[2] ? $_[1] <=> $_[0]->getValue : $_[0]->getValue <=> $_[1] },

  'eq' => sub { $_[0]->getValue eq $_[1] },
  'ne' => sub { $_[0]->getValue ne $_[1] },
  'cmp' => sub { $_[2] ? $_[1] cmp $_[0]->getValue : $_[0]->getValue cmp $_[1] },

  '~' => sub { ~( $_[0]->getValue + 0 ) },

  '&' => sub { $_[0]->getValue & $_[1] },
  '|' => sub { $_[0]->getValue | $_[1] },
  '^' => sub { $_[0]->getValue ^ $_[1] },

  '<<' => sub { $_[2] ? $_[1] << $_[0]->getValue : $_[0]->getValue << $_[1] },
  '>>' => sub { $_[2] ? $_[1] >> $_[0]->getValue : $_[0]->getValue >> $_[1] },

  'neg' => sub { -( $_[0]->getValue + 0 ) },

  '+' => sub { $_[0]->getValue + $_[1] },
  '-' => sub { $_[2] ? $_[1] - $_[0]->getValue : $_[0]->getValue - $_[1] },

  '*' => sub { $_[0]->getValue * $_[1] },
  '/' => sub { $_[2] ? $_[1] / $_[0]->getValue : $_[0]->getValue / $_[1] },
  '%' => sub { $_[2] ? $_[1] % $_[0]->getValue : $_[0]->getValue % $_[1] },

  '**' => sub { $_[2] ? $_[1]**$_[0]->getValue : $_[0]->getValue**$_[1] },

  'int'  => sub { int $_[0]->getValue },
  'cos'  => sub { cos $_[0]->getValue },
  'sin'  => sub { sin $_[0]->getValue },
  'exp'  => sub { exp $_[0]->getValue },
  'abs'  => sub { abs $_[0]->getValue },
  'log'  => sub { log $_[0]->getValue },
  'sqrt' => sub { sqrt $_[0]->getValue },

  #  '@{}' => sub  { X3DMessage->NotArrayReference(2, @_) },
  ;

1;
__END__
