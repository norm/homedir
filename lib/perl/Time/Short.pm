package Time::Short;

use strict;
use warnings;

use Exporter;
use Readonly;

our @ISA    = qw( Exporter );
our @EXPORT = qw( short_time );

Readonly my $SECOND =>  1;
Readonly my $MINUTE =>  60 * $SECOND;
Readonly my $HOUR   =>  60 * $MINUTE;
Readonly my $DAY    =>  24 * $HOUR;
Readonly my $WEEK   =>   7 * $DAY;
Readonly my $YEAR   => 365 * $DAY;


sub short_time {
    my $seconds = shift;
    my $time;
    
    if ( $seconds > $YEAR ) {
        $time = sprintf( '%2dy%2dw', 
                         $seconds / $YEAR,
                         ( $seconds % $YEAR ) / $WEEK
                );
    }
    if ( $seconds < $YEAR ) {
        $time = sprintf( '%2dw%2dd', 
                         $seconds / $WEEK,
                         ( $seconds % $WEEK ) / $DAY 
                );
    }
    if ( $seconds < $WEEK ) {
        $time = sprintf( '%2dd%2dh', 
                         $seconds / $DAY,
                         ( $seconds % $DAY ) / $HOUR
                );
    }
    if ( $seconds < $DAY ) {
        $time = sprintf( '%2dh%02dm', 
                         $seconds / $HOUR,
                         ( $seconds % $HOUR ) / $MINUTE
                );
    }
    if ( $seconds < $HOUR ) {
        $time = sprintf( '%2dm%02ds', $seconds / $MINUTE, 
                                       $seconds % $MINUTE );
    }
    if ( $seconds < $MINUTE ) {
        $time = sprintf( '   %2ds', $seconds );
    }

    return $time;
}