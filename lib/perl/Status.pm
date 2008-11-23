package Status;

use strict;
use warnings;

use IO::Interactive     qw( is_interactive );
use Readonly;
use Term::ANSIColor;

use Exporter;
our @ISA    = qw( Exporter );
our @EXPORT = qw( status  status_line  print_line );

Readonly my $MAX_LINE_LENGTH => 77;     # 80 -indent -right-margin


# make sure output is sent immediately
$| = 1;


sub status {
    my $text   = pad_text( shift );
    my $colour = shift || q();

    print colored( "$text\r", $colour ) if is_interactive();
}
sub status_line {
    my $text   = pad_text( shift );
    my $colour = shift || q();
    
    print is_interactive() ? colored( "$text\n", $colour )
                           : "$text\n";
}
sub print_line {
    my $text   = pad_text( shift, 1 );
    my $colour = shift || q();

    print is_interactive() ? colored( "$text\n", $colour )
                           : "$text\n";
}


sub pad_text {
    my $text    = shift;
    my $no_left = shift;
    
    chomp $text;
    my $len = length($text);

    # replace the text in the middle with ... if it is wider than the max
    if ( $MAX_LINE_LENGTH < $len ) {
        my $over   = ( $len+3 ) - $MAX_LINE_LENGTH;
        my $mid    = int( $len  / 2 );
        my $strip  = int( $over / 2 );
        my $offset = $mid - $strip;
    
        substr( $text, $offset, $over, '...' );
    }
    
    my $left  = defined $no_left ? q() : q(  );
    my $right = q{ } x ( $MAX_LINE_LENGTH - $len );
    return $left . $text . $right;
}

1;
