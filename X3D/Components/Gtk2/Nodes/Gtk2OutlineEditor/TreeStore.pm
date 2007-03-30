package Gtk2OutlineEditor::TreeStore;
use strict;
use warnings;

use rlib "./";
use rlib "../../../";

use Gtk2;
use Glib qw(TRUE FALSE);

use X3DError;
use Gtk2OutlineEditor::TreeModel;

#
#  here we register our new type and its interfaces with the type system.
#  If you want to implement additional interfaces like GtkTreeSortable,
#  you will need to do it here.
#

use Glib::Object::Subclass Gtk2OutlineEditor::TreeModel::,
  ;

############################################################################
############################################################################
############################################################################

sub set_children {
	X3DError::Debug;
	my ( $this, $field ) = @_;
	$this->{root} = $field;
	my $children = $field->getValue;

	foreach ( 0 ... $#$children ) {
		my $path = new Gtk2::TreePath($_);
		my $iter = $this->get_iter($path);
		$this->row_inserted( $path, $iter );
		$this->row_has_child_toggled( $path, $iter );
	}
}

1;
__END__
