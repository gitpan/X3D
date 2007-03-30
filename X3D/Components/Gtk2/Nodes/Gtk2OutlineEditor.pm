package Gtk2OutlineEditor;
use strict;
use warnings;

use rlib "../";

use base qw(X3DGtk2Widget);

use X3DConstants;
use Gtk2OutlineEditor::TreeView;

our $FieldDefinitions = [
	new X3DFieldDefinition( inputOutput, 'title',    new SFString ),
	new X3DFieldDefinition( inputOutput, 'children', new MFNode ),
];

sub create {
	my ($this) = @_;

	my $vbox            = new Gtk2::VBox( FALSE, 0 );
	my $scrolled_window = new Gtk2::ScrolledWindow;
	my $treeView        = new Gtk2OutlineEditor::TreeView;

	$scrolled_window->add_with_viewport($treeView);
	$vbox->pack_start( $scrolled_window, TRUE, TRUE, 0 );

	#$vbox->pack_start( new Gtk2::Button, FALSE, FALSE, 0 );
	#$vbox->pack_start( new Gtk2::Statusbar, FALSE, FALSE, 0 );

	$this->{treeView} = $treeView;
	$this->setWidget($vbox);
}

sub initialize {
	my ($this) = @_;
	$this->_children($this->children);
}

sub _children {
	my ($this, $value) = @_;
	$this->{treeView}->get_model->set_children($this->getField("children"));
}

1;
__END__
