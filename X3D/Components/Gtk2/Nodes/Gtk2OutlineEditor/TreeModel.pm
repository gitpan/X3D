package Gtk2OutlineEditor::TreeModel;
use strict;
use warnings;

use rlib "../../../";

use Gtk2;
use Glib qw(TRUE FALSE);

use Array;
use X3DError;

# maybe bad style, but makes life a lot easier
use base qw(Exporter);

our @EXPORT = qw(
  COL_IS_NODE
  COL_NODE
  COL_IS_FIELD
  COL_FIELD
  COL_ROUTE
);
# The data columns that we export via the tree model interface

use enum qw(
  COL_IS_NODE
  COL_NODE
  COL_IS_FIELD
  COL_FIELD
  COL_ROUTE
  N_COLUMNS
);

#
#  here we register our new type and its interfaces with the type system.
#  If you want to implement additional interfaces like GtkTreeSortable,
#  you will need to do it here.
#

use Glib::Object::Subclass Glib::Object::,
  interfaces => [Gtk2::TreeModel::],
  ;

#
# this is called everytime a new custom list object
# instance is created (we do that in new).
# Initialise the list structure's fields here.
#

sub INIT_INSTANCE {
	#X3DError::Debug;
	my $this = shift;

	$this->{n_columns}    = N_COLUMNS;
	$this->{column_types} = [
		'Glib::Boolean',    # COL_IS_NODE
		'Glib::Scalar',     # COL_NODE
		'Glib::Boolean',    # COL_IS_FIELD
		'Glib::Scalar',     # COL_FIELD
		'Glib::Uint',       # COL_ROUTE
	];

	$this->{root}   = undef;
	$this->{record} = {};

	# Random int to check whether an iter belongs to our model
	$this->{stamp} = sprintf '%d', rand( 1 << 31 );
}

#
#  this is called just before a custom list is
#  destroyed. Free dynamically allocated memory here.
#

sub FINALIZE_INSTANCE {
	#X3DError::Debug;
	my $this = shift;

	# free all records and free all memory used by the list
	#X3DError::Debuging IMPLEMENT
}

#
# tells the rest of the world whether our tree model has any special
# characteristics. In our case, we have a list model (instead of a tree).
# Note that unlike the C version of this custom model, our iters do NOT
# persist.
#

#sub GET_FLAGS { X3DError::Debug; [qw/list-only iters-persist/] }
sub GET_FLAGS { X3DError::Debug; [] }

#
# tells the rest of the world how many data
# columns we export via the tree model interface
#

sub GET_N_COLUMNS { X3DError::Debug; shift->{n_columns}; }

#
# tells the rest of the world which type of
# data an exported model column contains
#

sub GET_COLUMN_TYPE {
	#X3DError::Debug;
	my ( $this, $index ) = @_;
	# and invalid index will send undef back to the calling XS layer,
	# which will croak.
	return $this->{column_types}[$index];
}

#
# converts a tree path (physical position) into a
# tree iter structure (the content of the iter
# fields will only be used internally by our model).
# We simply store a pointer to our CustomRecord
# structure that represents that row in the tree iter.
#

sub GET_ITER {
	my ( $this, $path ) = @_;
	#X3DError::Debug $path->to_string;

	my @indices = $path->get_indices;
	my $depth   = $path->get_depth;

	return undef unless $this->{root};

	my $n      = 0;
	my $object = $this->{root};
	my $parent;

	foreach (@indices) {
		$n = $_;
		if ( $object->isa('SFNode') ) {
			my $node      = $object->getValue;
			my $fieldName = $node->getFieldDefinitions->[$n]->getName;
			$object = $node->getField($fieldName);
		} elsif ( $object->isa('X3DField') ) {
			if ( $object->getType eq "MFNode" ) {
				$parent = $object;
				$object = $object->getValue;
				# Is this the last record in the list?
				return undef if $n > $#$object;
				$object = $object->[$n];
			}
		}
	}

	return undef unless ref $object;

	X3DError::Debug $n, $object->getValue->getName, $object->getValue->getType if $object->isa('SFNode');
	return $this->ITER( $n, $object, $parent );
}

#
#  get_path: converts a tree iter into a tree path (ie. the
#                        physical position of that row in the list).
#

sub GET_PATH {
	#X3DError::Debug;
	my ( $this, $iter ) = @_;
	die "no iter" unless $iter;

	my $record = $iter->[2]->{parent};

	my $path = Gtk2::TreePath->new;
	$path->append_index( $record->{pos} );
	return $path;
}

#
# get_value: Returns a row's exported data columns
#                        (_get_value is what gtk_tree_model_get uses)
#

sub GET_VALUE {
	my ( $this, $iter, $column ) = @_;
	#X3DError::Debug @$iter;

	die "bad iter" unless $iter;

	return undef unless $column < @{ $this->{column_types} };

	my $object = $iter->[2]->{object};
	#my $parent = $iter->[2]->{parent};

	return undef unless ref $object;

	if ( $object->isa("SFNode") ) {
		return TRUE    if $column == COL_IS_NODE;
		return $object if $column == COL_NODE;
		return 1       if $column == COL_ROUTE;

	} elsif ( $object->isa("X3DField") ) {
		return TRUE    if $column == COL_IS_FIELD;
		return $object if $column == COL_FIELD;
		return 2       if $column == COL_ROUTE;
	}

	return;
}

#
# iter_next: Takes an iter structure and sets it to point to the next row.
#

sub ITER_NEXT {
	my ( $this, $iter ) = @_;

	my $n      = $iter->[1] + 1;
	my $object = $iter->[2]->{object};
	my $parent = $iter->[2]->{parent};

	X3DError::Debug "*" x 3;
	X3DError::Debug $n, "object: ", ref $object;
	X3DError::Debug $n, "parent: ", ref $parent;
	X3DError::Debug $n, $object->getValue->getName, $object->getValue->getType if $object->isa('SFNode');
	X3DError::Debug $n, $object->getType, $object->getName if $object->isa('X3DField');

	if ( $object->isa("SFNode") ) {
		if ( $parent->getType eq "MFNode" ) {
			$object = $parent->getValue;
			# Is this the last record in the list?
			return undef if $n > $#$object;
			$object = $object->[$n];
		}
	} elsif ( $object->isa("X3DField") ) {
		my $node             = $parent->getValue;
		my $fieldDefinitions = $node->getFieldDefinitions;
		return undef if $n > $#$fieldDefinitions;

		my $fieldName = $node->getFieldDefinitions->[$n]->getName;
		$object = $node->getField($fieldName);
	} else {
		die;
	}

	die unless ref $object;

	X3DError::Debug;
	X3DError::Debug $n, ref $object;
	X3DError::Debug $n, $object->getValue->getName, $object->getValue->getType if $object->isa('SFNode');
	X3DError::Debug $n, $object->getType, $object->getName if $object->isa('X3DField');
	return $this->ITER( $n, $object, $parent );
}

#
# iter_children: Returns TRUE or FALSE depending on whether the row
#                specified by 'parent' has any children.  If it has
#                children, then 'iter' is set to point to the first
#                child.  Special case: if 'parent' is undef, then the
#                first top-level row should be returned if it exists.
#

sub ITER_CHILDREN { &ITER_NTH_CHILD( @_, 0 ) }

#
# iter_has_child: Returns TRUE or FALSE depending on whether
#                 the row specified by 'iter' has any children.
#                 We only have a list and thus no children.
#

sub ITER_HAS_CHILD { &ITER_N_CHILDREN(@_) }

#
# iter_n_children: Returns the number of children the row specified by
#                  'iter' has. This is usually 0, as we only have a list
#                  and thus do not have any children to any rows.
#                  A special case is when 'iter' is undef, in which case
#                  we need to return the number of top-level nodes, ie.
#                  the number of rows in our list.
#

sub ITER_N_CHILDREN {
	my ( $this, $iter ) = @_;

	X3DError::Debug( ref $iter ? 1 : 0 );

	# special case: if iter == NULL, return number of top-level rows
	return $this->{root}->getValue->length if !$iter;

	my $n      = 0;
	my $object = $iter->[2]->{object};

	X3DError::Debug ref $object;

	if ( $object->isa("SFNode") ) {
		my $node             = $object->getValue;
		my $fieldDefinitions = $node->getFieldDefinitions;
		#X3DError::Debug scalar @$fieldDefinitions;
		$n = @$fieldDefinitions;
	} elsif ( $object->isa("X3DField") ) {
		$object = $object->getValue;

		$n = $object->length if $object->isa("MFNode");
	}

	X3DError::Debug $n;
	return $n;
}

#
# iter_nth_child: If the row specified by 'parent' has any children,
#                 set 'iter' to the n-th child and return TRUE if it
#                 exists, otherwise FALSE.  A special case is when
#                 'parent' is NULL, in which case we need to set 'iter'
#                 to the n-th row if it exists.
#

sub ITER_NTH_CHILD {
	my ( $this, $iter, $n ) = @_;

	# iter == NULL is a special case; we need to return the first top-level row
	my $object = $iter ? $iter->[2]->{object} : $this->{root};
	my $parent = $object;

	X3DError::Debug $n, ref $object;
	X3DError::Debug $n, $object->getValue->getName, $object->getValue->getType if $object->isa('SFNode');
	X3DError::Debug $n, $object->getType, $object->getName if $object->isa('X3DField');

	if ( $object->isa("SFNode") ) {
		my $node             = $object->getValue;
		my $fieldDefinitions = $node->getFieldDefinitions;
		return undef if $n > $#$fieldDefinitions;

		my $fieldName = $fieldDefinitions->[$n]->getName;
		$object = $node->getField($fieldName);
	} elsif ( $object->isa("X3DField") ) {
		$object = $object->getValue;

		if ( $object->isa("MFNode") ) {
			return undef if $n > $#$object;
			$object = $object->[$n];
		}

		#X3DError::Debug "X3DField", ref $object;
	} else {
		die;
	}

	X3DError::Debug $n, ref $object;
	#X3DError::Debug $n, ref $parent, ref $object;
	return $this->ITER( $n, $object, $parent );
}

#
# iter_parent: Point 'iter' to the parent node of 'child'.  As we have a
#              a list and thus no children and no parents of children,
#              we can just return FALSE.
#

sub ITER_PARENT {
	my ( $this, $iter ) = @_;

	my $n;
	my $object = $iter->[2]->{object};
	my $parent = $iter->[2]->{parent};

	X3DError::Debug "object: ", ref $object;
	X3DError::Debug "parent: ", ref $parent;
	X3DError::Debug "  root: ", ref $this->{root};
	X3DError::Debug $object->getValue->getName, $object->getValue->getType if $object->isa('SFNode');
	X3DError::Debug $object->getType, $object->getName if $object->isa('X3DField');

	return undef if $parent == $this->{root};
	X3DError::Debug;

	if ( $object->isa("SFNode") ) {
		die;
		# 		$object = $object->getParents;
		#
		# 		$parent = $object->getParents;
		# 		if ( $parent->isa("SFNode") ) {
		# 			$n = Array::index( [ $parent->getFieldDefinitions ], $object );
		# 		} elsif ( $parent->isa("MFNode") ) {
		# 			$n = $parent->index($object);
		# 		}
		#
		# 		X3DError::Debug $parent, $object;
	} elsif ( $object->isa("X3DField") ) {
		if ($object->getType eq "SFNode") {
			my ($node) = $parent->getValue->getParents;
			
			my $field = GetFieldFromSFNode($node, $parent);
			X3DError::Debug $node->getType, $field->getName;
	
			$n = 0;
			$object = $parent;
			$parent = $field;
		} else {
			die;
		}
	} else {
		X3DError::Debug "else", ref $object;

		die;
	}

	X3DError::Debug $n, ref $object;
	X3DError::Debug $n, $object->getValue->getName, $object->getValue->getType if $object->isa('SFNode');
	X3DError::Debug $n, $object->getType, $object->getName if $object->isa('X3DField');

	return if $object == $this->{root};
	return $this->ITER( $n, $object, $parent );
}

sub GetFieldFromSFNode {
	my $node   = shift;
	my $sfnode = shift;

	foreach my $field ( $node->getFields(TRUE) ) {
 		if ( $field->getType eq "SFNode" ) {
 			return $field if $field->getValue == $sfnode;
 		} elsif ( $field->getType eq "MFNode" ) {
 			foreach ( @{ $field->getValue } ) {
 				return $field if $_ == $sfnode;
 			}
 		}
	}

	return;
}

sub ITER {
	my ( $this, $n, $object, $parent ) = @_;
	$this->{record}->{object} = $object;
	$this->{record}->{parent} = $parent;
	return [ $this->{stamp}, $n, $this->{record} ];
}

#
# ref_node and unref_node get called as the model manages the lifetimes
# of nodes in the model.  you normally don't need to do anything for these,
# but may want to if you plan to implement data caching.
#
#sub REF_NODE { X3DError::Debug; X3DError::Debug "REF_NODE @_\n"; }
#sub UNREF_NODE { X3DError::Debug; X3DError::Debug "UNREF_NODE @_\n"; }

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

#
# set: It's always nice to be able to update the data stored in a data
#      structure.  So, here's a method to let you do that.  We emit the
#      'row-changed' signal to notify all who care that we've updated
#      something.
#

sub set { #X3DError::Debug;
	my $this     = shift;
	my $treeiter = shift;

	# create (col, value) pairs to update.
	my %vals = @_;

	# Convert the Gtk2::TreeIter to a more useable array reference.
	# Note that the model's stamp must be passed in as an argument.
	# This is so we can avoid trying to extract the guts of an iter
	# that we did not create in the first place.
	my $iter = $treeiter->to_arrayref( $this->{stamp} );

	my $record = $iter->[2];

	while ( my ( $col, $val ) = each %vals ) {
		if ( $col == COL_NODE ) {
			$record->{name} = $val;
		} elsif ( $col == COL_YEAR_BORN ) {
			$record->{year_born} = $val;
		} elsif ( $col == COL_RECORD ) {
			#X3DError::Debug "Can't update the value of the Record column!";
		} else {
			#X3DError::Debug "Invalid column used in set method!";
		}
	}

	$this->row_changed( $this->get_path($treeiter), $treeiter );
}

#
# get_iter_from_name: Sometimes, you have a bit of information that
#                     uniquely identifies a record in your TreeModel,
#                     but it doesn't convert easily to a TreePath,
#                     so it's hard to get a TreeIter out of it.  This
#                     is an example of how to make a TreeModel that
#                     can get iterators without having to find the path
#                     first.
#

sub get_iter_from_name { #X3DError::Debug;
	my $this = shift;
	my $name = shift;

	my ( $record, $n );

	for ( 0 .. scalar( @{ $this->{rows} } ) ) {
		if ( $this->{rows}[$_]->{name} eq $name ) {
			$record = $this->{rows}[$_];
			$n      = $_;
			last;
		}
	}

	return Gtk2::TreeIter->new_from_arrayref( [ $this->{stamp}, $n, $record, undef ] );
}

#
# append_record:  Empty lists are boring. This function can be used in your
#                 own code to add rows to the list.  Note how we emit the
#                 "row-inserted" signal after we have appended the row
#                 so the tree view and other interested objects know about
#                 the new row.
#

sub append_record { #X3DError::Debug;
	my ( $this, $name, $year_born ) = @_;

	croak "usage: \$list->append_record (NAME, YEAR_BORN)"
	  unless $name;

	my $newrecord = {
		name => $name,
		#		name_collate_key => g_utf8_collate_key(name,-1), # for fast sorting, used later
		year_born => $year_born,
	};

	push @{ $this->{rows} }, $newrecord;
	$newrecord->{pos} = @{ $this->{rows} } - 1;

	# inform the tree view and other interested objects
	# (e.g. tree row references) that we have inserted
	# a new row, and where it was inserted

	my $path = Gtk2::TreePath->new;
	$path->append_index( $newrecord->{pos} );
	$this->row_inserted( $path, $this->get_iter($path) );
}

############################################################################
############################################################################
############################################################################

sub fill_model { #X3DError::Debug;
	my $this = shift;

	my @firstnames = qw(Joe Jane William Hannibal Timothy Gargamel);
	my @surnames   = qw(Grokowich Twitch Borheimer Bork);

	foreach my $sname (@surnames) {
		foreach my $fname (@firstnames) {
			$this->append_record( "$fname $sname", 1900 + rand(103.0) );
		}
	}
}
