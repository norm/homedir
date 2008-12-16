package Text::Trim;

use strict;
use warnings;

use Exporter;
our @ISA       = qw( Exporter );
our @EXPORT    = qw( trim_text pad_text );


sub trim_text {
    my $text       = shift;
    my $max_length = shift;
    my $position   = shift || q(c);
    
    my $length = length $text;
    
    if ( $max_length < $length ) {
        my $over   = ( $length + 3 ) - $max_length;
        my $middle = int( $length  / 2 );
        my $strip  = int( $over    / 2 );
        my $offset = $middle - $strip;

        if ( q(l) eq $position ) {
            $offset = $offset - ( $offset / 2 );
        }
        elsif ( q(r) eq $position ) {
            $offset = $offset + ( $offset / 2 );
        }
        
        substr( $text, $offset, $over, '...' );
    }
    
    return $text;
}
sub pad_text {
    my $text       = shift;
    my $max_length = shift;
    my $no_trim    = shift || q();

    if ( !$no_trim ) {
        $text = trim_text( $text, $max_length );
    }
    
    my $length = length $text;

    if ( $length < $max_length ) {
        $text .= q( ) x ( $max_length - $length );
    }
    
    return $text;
}

1;
