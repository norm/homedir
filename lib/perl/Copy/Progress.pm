package Copy::Progress;

use strict;
use warnings;

use FileHandle;
use Readonly;
use Status;
# use Term::ProgressBar::Quiet;
use Term::Progress;
use Text::Trim;

use Exporter;
our @ISA    = qw( Exporter );
our @EXPORT = qw( copy_progress  move_progress );

Readonly my $BLOCK_SIZE      => 1024 * 1024 * 10;  # 10mb blocks


# filesystem operations
sub copy_progress {
    my $source  = shift;
    my $target  = shift;
    my $message = shift || "  copy: ${target}";
       # $message = trim_text( $message, 30 ); 
    
    my $src_handle = new FileHandle $source;
    my $file_size = ( stat($source) )[7];
    
    
    my $tgt_handle = new FileHandle $target, q(w);
    my $progress   = Term::Progress->new( 
                         'count'  => $file_size,
                         'format' => "$message {bar} {remaining}"
                     );
    
    die "$source: $!" unless defined $src_handle;
    die "$target: $!" unless defined $tgt_handle;
    
    my $buffer;
    my $total_written;
    
    while (1) {
        my $bytes_read = $src_handle->sysread( $buffer, $BLOCK_SIZE );
        return undef unless defined $bytes_read;  # undef means error
        last if ($bytes_read == 0);               # 0 is end-of-file
        
        my $offset;
        
        while ( $bytes_read ) {
            my $bytes_written 
                = $tgt_handle->syswrite( $buffer, $bytes_read, $offset );
            
            return undef unless defined $bytes_written;  # undef means error
            
            $bytes_read    -= $bytes_written;
            $offset        += $bytes_written;
            $total_written += $bytes_written;
            
            my $percentage = int( ($total_written / $file_size) * 100 );
            
            $progress->now( $total_written );
        }
    }
    print_line( $target, q(green) );
    return 1;
}


sub move_progress {
    my $source  = shift;
    my $target  = shift;
    my $message = shift || "  move: ${target}";
       $message = trim_text( $message, 30 ); 
    
    # either rename
    my $worked = rename $source, $target;
    
    # ...or copy/delete
    if ( !$worked ) {
        if ( !defined copy_progress( $source, $target, $message ) ) {
            return undef;
        }
        return unlink $source;
    }
    else {
        print_line( $target, q(green) );
    }
    
    return 1;
}

1;
