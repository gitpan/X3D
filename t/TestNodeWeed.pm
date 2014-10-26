package TestNodeX3D;
use strict;

BEGIN {
	$| = 1;
	chdir 't' if -d 't';
	unshift @INC, '../lib';
}

use X3D 'X3D : X3DBaseNode {
  SFNode   [in,out] metadata    NULL    [X3DMetadataObject]
  MFString []       family      "SERIF"
  SFBool   []       horizontal  FALSE
  MFString []       justify     ["BEGIN", "FIRST"] ["BEGIN"|"END"|"FIRST"|"MIDDLE"|""]
  MFString []       string     []
  MFFloat  []       floats     [1,2,3]
  SFString []       language    ""
  SFBool   []       leftToRight TRUE
  SFFloat  []       size        1.0     (0,\u221e)
  SFFloat  []       spacing     1.0     [0,\u221e)
  SFString [in,out]    style       "BOLD" ["PLAIN"|"BOLD"|"ITALIC"|"BOLDITALIC"|""]
  SFBool   [in]     topToBottom
}
';

1;
__END__
