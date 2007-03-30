package Gtk2OutlineEditor::TreeView;
use strict;
use warnings;

use rlib "./";

use Gtk2;
use Glib qw(TRUE FALSE);

use Gtk2OutlineEditor::TreeStore;
use Gtk2OutlineEditor::CellRendererNode;
use Gtk2OutlineEditor::CellRendererField;

use Glib::Object::Subclass Gtk2::TreeView::,;

#
# this is called everytime a new custom list object
# instance is created (we do that in new).
# Initialise the list structure's fields here.
#

sub INIT_INSTANCE {
	my ($this) = @_;

	$this->modify_base( 'normal', Gtk2::Gdk::Color->parse("#edebec") );

	my $model = new Gtk2OutlineEditor::TreeStore;
	$this->set_model($model);

	#
	# Hide default expander
	# 	{
	# 		my $column = new Gtk2::TreeViewColumn;
	# 		$column->set_visible(FALSE);
	# 		$this->append_column($column);
	# 		$this->set_expander_column($column);
	# 	}

	#
	# Nodes
	{
		my $column = new Gtk2::TreeViewColumn;
		$column->set_title("Nodes");
		$this->append_column($column);

		my $nodeRenderer = new Gtk2OutlineEditor::CellRendererNode;
		#$renderer->signal_connect( edited => \&on_name_edited, $model );
		#$renderer->set( editable => TRUE );
		$column->pack_start( $nodeRenderer, TRUE );
		$column->add_attribute( $nodeRenderer, visible => &Gtk2OutlineEditor::TreeModel::COL_IS_NODE );
		$column->add_attribute( $nodeRenderer, node => &Gtk2OutlineEditor::TreeModel::COL_NODE );

		my $fieldRenderer = new Gtk2OutlineEditor::CellRendererField;
		$column->pack_start( $fieldRenderer, TRUE );
		$column->add_attribute( $fieldRenderer,
			visible => &Gtk2OutlineEditor::TreeModel::COL_IS_FIELD );
		$column->add_attribute( $fieldRenderer, field => &Gtk2OutlineEditor::TreeModel::COL_FIELD );
	}

	#
	# Routes
	{
		my $column = new Gtk2::TreeViewColumn;
		$column->set_title("Routes");
		$this->append_column($column);

		my $renderer = new Gtk2::CellRendererText;
		$column->pack_start( $renderer, TRUE );
		$column->add_attribute( $renderer, text => &Gtk2OutlineEditor::TreeModel::COL_ROUTE );
	}

}

&register_icons;

sub register_icon {
	my ( $stock_id, $rel_path ) = @_;

	my $path;
	foreach (@INC) {
		$path = "$_/Gtk2OutlineEditor/pixmaps/$rel_path" if -e "$_/Gtk2OutlineEditor/pixmaps/$rel_path";
	}

	if ($path) {
		my $icon;
		eval { $icon = Gtk2::Gdk::Pixbuf->new_from_file($path) };
		if ($@) {
			croak("Unable to load icon at '$path': $@");
		}

		Gtk2::IconTheme->add_builtin_icon( $stock_id, 12, $icon );
	} else {
		#croak "TreeView::register_icon: '$rel_path' not registered";
	}
}

sub register_icons {

	register_icon( 'X3DProto', 'X3DProto.xpm' );
	register_icon( 'X3DNode',  'X3DNode.xpm' );

	register_icon( 'MFBool',      'MFBool.xpm' );
	register_icon( 'MFColorRGBA', 'MFColorRGBA.xpm' );
	register_icon( 'MFColor',     'MFColor.xpm' );
	register_icon( 'MFDouble',    'MFDouble.xpm' );
	register_icon( 'MFFloat',     'MFFloat.xpm' );
	register_icon( 'MFImage',     'MFImage.xpm' );
	register_icon( 'MFInt32',     'MFInt32.xpm' );
	register_icon( 'MFNode',      'MFNode.xpm' );
	register_icon( 'MFRotation',  'MFRotation.xpm' );
	register_icon( 'MFString',    'MFString.xpm' );
	register_icon( 'MFTime',      'MFTime.xpm' );
	register_icon( 'MFVec2d',     'MFVec2d.xpm' );
	register_icon( 'MFVec2f',     'MFVec2f.xpm' );
	register_icon( 'MFVec3d',     'MFVec3d.xpm' );
	register_icon( 'MFVec3f',     'MFVec3f.xpm' );

	register_icon( 'SFBool',      'SFBool.xpm' );
	register_icon( 'SFColorRGBA', 'SFColorRGBA.xpm' );
	register_icon( 'SFColor',     'SFColor.xpm' );
	register_icon( 'SFDouble',    'SFDouble.xpm' );
	register_icon( 'SFFloat',     'SFFloat.xpm' );
	register_icon( 'SFImage',     'SFImage.xpm' );
	register_icon( 'SFInt32',     'SFInt32.xpm' );
	register_icon( 'SFNode',      'SFNode.xpm' );
	register_icon( 'SFRotation',  'SFRotation.xpm' );
	register_icon( 'SFString',    'SFString.xpm' );
	register_icon( 'SFTime',      'SFTime.xpm' );
	register_icon( 'SFVec2d',     'SFVec2d.xpm' );
	register_icon( 'SFVec2f',     'SFVec2f.xpm' );
	register_icon( 'SFVec3d',     'SFVec3d.xpm' );
	register_icon( 'SFVec3f',     'SFVec3f.xpm' );

}

1;
__END__
sub on_name_edited {
	my ( $cell, $pathstring, $newtext, $model ) = @_;
	my $path = Gtk2::TreePath->new_from_string($pathstring);
	my $iter = $model->get_iter($path);
	$model->set( $iter, &X3DGtk2TreeStore::COL_NAME, $newtext );
}

