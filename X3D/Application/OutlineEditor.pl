#!/usr/bin/perl
use lib "$ENV{HOME}/perl";

use X3D;
$X3DGenerator::AllFields = 1;
Browser->createX3DFromString(<DATA>);
#Browser->replaceWorld( Browser->createX3DFromString(<DATA>) );
Gtk2->main;

printf "%s\n", Browser;

1;
__DATA__

COMPONENT Gtk2 1

META "name" "Outliner"
META "version" "0.01"

DEF Gtk2Main Gtk2Main {},
DEF OutlineEditorWindow Gtk2Window {
  title "OutlineEditor"
  x 400
  y 300
  width 400
  height 600
  whichChoice 0
  children Gtk2OutlineEditor {
    title "Outline"
	 children [
		DEF Double MetadataDouble {},
		MetadataFloat {},
		DEF Set MetadataSet {
			value [
				MetadataFloat {},
			]
		},
		MetadataString {},
		USE Set,
	 ]
  }
}

ROUTE OutlineEditorWindow.exitTime TO Gtk2Main.stopTime
