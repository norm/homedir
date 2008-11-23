package Copy::Progress;

use strict;
use warnings;

use FileHandle;
use Readonly;
use Status;
use Text::ProgressBar;

use Exporter;
our @ISA    = qw( Exporter );
our @EXPORT = qw( copy_progress  move_progress );

Readonly my $BLOCK_SIZE      => 1024 * 1024 * 10;  # 10mb blocks


# filesystem operations
sub copy_progress {
    my $source   = shift;
    my $target   = shift;
    my $progress = shift || "Copying ${target} %s";

    my $src_handle = new FileHandle $source;
    my $tgt_handle = new FileHandle $target, q(w);
    my $bar        = Text::ProgressBar->new( 
                         { 'width' => 20, 'percentage' => 0 } 
                     );
        
    die "$source: $!" unless defined $src_handle;
    die "$target: $!" unless defined $tgt_handle;
    
    my $file_size = ( stat($source) )[7];
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
            my $text       = $bar->report( $percentage );
            status( sprintf( $progress, $text ), q(yellow) );
        }
    }
    status_line( $target, q(green) );
    
    return 1;
}


sub move_progress {
    my $source   = shift;
    my $target   = shift;
    my $progress = shift || "Moving ${target} %s";
    
    # either rename
    my $worked = rename $source, $target;
    
    # ...or copy/delete
    if ( !$worked ) {
        if ( !defined copy_progress( $source, $target, $progress ) ) {
            return undef;
        }
        return unlink $source;
    }
    else {
        status_line( $target, q(green) );
    }
    
    return 1;
}

1;
