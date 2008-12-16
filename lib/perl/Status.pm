package Status;

use strict;
use warnings;

use IO::Interactive     qw( is_interactive );
use Readonly;
use Term::ANSIColor;
use Text::Trim;


use Exporter;
our @ISA    = qw( Exporter );
our @EXPORT = qw( status  status_line  print_line );

Readonly my $MAX_LINE_LENGTH => 79;     # 80 - 1 for right-margin


# make sure output is sent immediately
$| = 1;


sub status {
    my $text   = pad_text( shift, $MAX_LINE_LENGTH );
    my $colour = shift || q();

    print colored( "$text\r", $colour ) if is_interactive();
}
sub status_line {
    my $text   = pad_text( shift, $MAX_LINE_LENGTH );
    my $colour = shift || q();
    
    print is_interactive() ? colored( "$text\n", $colour )
                           : "$text\n";
}
sub print_line {
    my $text   = pad_text( shift, $MAX_LINE_LENGTH, 'no-trim' );
    my $colour = shift || q();

    print is_interactive() ? colored( "$text\n", $colour )
                           : "$text\n";
}

1;
