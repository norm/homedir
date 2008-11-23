package Text::ProgressBar;

use strict;
use warnings;


sub new {
    my $class = shift;
    my $opt   = shift;
    my $self  = {
        'border'     => q(|),
        'empty_cell' => q(.),
        'half_cell'  => q(o),
        'full_cell'  => q(8),
        'percentage' => 'right',
        'width'      => 50,
    };

    if ( defined $opt ) {
        foreach my $key ( keys %{$opt} ) {
            $self->{$key} = $opt->{$key};
        }
    }

    bless $self;
    return $self;
}


sub report {
    my $self       = shift;
    my $percentage = shift;
    
    my $full_cells = $self->get_full_cells( $percentage );

    # full cells
    my $report = $self->get_full_cell() x $full_cells;
    
    # possible half cell
    if ( int( $full_cells + 0.5 ) == int( $full_cells + 1 ) ) {
        $report .= $self->get_half_cell();
        $full_cells++;
    }
    
    # empty cells
    $report .= 
        $self->get_empty_cell() x ( $self->get_width() - int($full_cells) );
    
    # border
    $report = $self->add_borders( $report );
    
    # percentage
    $report = $self->add_percentage( $report, $percentage );
    
    return $report;
}


sub get_full_cells {
    my $self       = shift;
    my $percentage = shift;
    my $cell_width = 100 / $self->get_width();
    
    return $percentage / $cell_width;
}
sub add_borders {
    my $self = shift;
    my $text = shift;
    
    if ( my $border = $self->get_border() ) {
        return "${border}${text}${border}";
    }
    return $text;
}
sub add_percentage {
    my $self       = shift;
    my $report     = shift;
    my $percentage = shift;
    my $position   = $self->get_percentage_position();
    
    if ( defined $position  &&  q() ne $position ) {
        my $insert = sprintf ' %02d%% ', $percentage;

        if ( 'left' eq $position ) {
            $report = $insert . $report;
        }
        elsif ( 'right' eq $position ) {
            $report .= $insert;
        }
        elsif ( 'inside' eq $position ) {
            my $width = $self->get_width();
            
            my $index = int( $width / 4 );
            $index += int( $width / 2 ) - 1 if ( $percentage < 50 );
            $index -= 2;

            substr $report, $index, length( $insert ), $insert;
        }
        else {
            substr $report, $position, length( $insert ), $insert;
        }
    }
    
    return $report;
}


sub get_width {
    my $self = shift;
    
    return $self->{'width'};
}
sub set_width {
    my $self  = shift;
    my $width = shift;
    
    $self->{'width'} = $width;
}
sub get_border {
    my $self = shift;
    
    return $self->{'border'};
}
sub set_border {
    my $self   = shift;
    my $border = shift;
    
    $self->{'border'} = $border;
}
sub get_empty_cell {
    my $self = shift;
    
    return $self->{'empty_cell'};
}
sub set_empty_cell {
    my $self       = shift;
    my $empty_cell = shift;
    
    $self->{'empty_cell'} = $empty_cell;
}
sub get_half_cell {
    my $self = shift;
    
    return $self->{'half_cell'};
}
sub set_half_cell {
    my $self      = shift;
    my $half_cell = shift;
    
    $self->{'half_cell'} = $half_cell;
}
sub get_full_cell {
    my $self = shift;
    
    return $self->{'full_cell'};
}
sub set_full_cell {
    my $self      = shift;
    my $full_cell = shift;
    
    $self->{'full_cell'} = $full_cell;
}
sub get_percentage_position {
    my $self = shift;
    
    return $self->{'percentage'};
}
sub set_percentage_position {
    my $self     = shift;
    my $position = shift;
    
    $self->{'percentage'} = $position;
}

1;
