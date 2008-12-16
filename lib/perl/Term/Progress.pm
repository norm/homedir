package Term::Progress;

use strict;
use warnings;

use Readonly;
use Text::Trim;
use Time::Short;

Readonly my @tags => qw(  bar  remaining  count  update  );


sub new {
    my $proto = shift;
    my %args  = @_;

    my $class = ref $proto || $proto;
    my $self  = {
            'format'        => '{bar} {remaining}',
            'bar_length'    => 25,
            'max_width'     => 79,
            'trim_location' => 'l',
    };
    bless $self, $class;
    
    foreach my $arg ( keys %args ) {
        $self->{$arg} = $args{$arg};
    }
    
    $self->{'start'} = 0;
    
    return $self;
}


sub now {
    my $self     = shift;
    my $progress = shift;
    
    $self->{'progress'} = $progress;
    
    my $max_width     = $self->{'max_width'};
    my $trim_location = $self->{'trim_location'};
    
    my $output = trim_text( 
                     $self->format_text(), 
                     $max_width, 
                     $trim_location 
                 );
    print "$output\r";
}


sub remaining_seconds {
    my $self     = shift;
    
    
    my $count    = $self->{'count'};
    my $progress = $self->{'progress'};
    my $start    = $self->{'start'};
    if ( !$start ) {
        $self->{'start'} = time();
        $start           = $self->{'start'};
    }
    
    # very naive remaining time estimation based upon average only
    my $now        = time();
    my $elapsed    = $now - $start;
    my $remain     = $count - $progress;
    my $per_second = 0;
    my $estimation = 0;
    
    if ( $elapsed > 1 ) {
        $per_second = $progress / $elapsed;
        $estimation = int( $remain / $per_second );
    }
    
    return $estimation;
}



sub format_text {
    my $self = shift;
    my $text = shift || $self->{'format'};
    
    my $tags = join '|', @tags;
    
    $text =~ s{
            \{
                ( $tags )
            \}
        }{
            my $tag = $1;
            $self->$tag();
        }egx;
    
    return $text;
}


sub bar {
    my $self   = shift;
    my $length = $self->{'bar_length'};
    
    my $internal_length = $length - 2;
    my $percentage      = $self->percentage() / 100;
    my $bar_length      = int( $internal_length * $percentage );
    my $remain_length   = $internal_length - $bar_length;

    return q([)
         . ( q(=) x $bar_length    )
         . ( q( ) x $remain_length )
         . q(]);
}
sub remaining {
    my $self    = shift;
    my $seconds = $self->remaining_seconds();
    
    return short_time( $seconds );
}
sub count {
    my $self = shift;
    
    return $self->{'count'};
}
sub update {
    my $self = shift;
    
    return $self->{'progress'};
}
sub percentage {
    my $self = shift;
    
    my $progress   = $self->{'progress'};
    my $count      = $self->{'count'};
    my $percentage = 0;
    
    if ( $progress > 0 ) {
        $percentage = int( 100 * ( $progress / $count ) );
    }
    
    return $percentage;
}



1;
