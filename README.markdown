home directory
==============

This is my home directory. It contains all of the settings and custom 
configuration I like to use on a Unix computer.

It is built on top of my [bash-composition] project, because I like to
keep my shell initialisation in many small, purposeful files rather than
one big melange of a dotfile.

## copying individual files

You are welcome to copy any of these files to your own home directory.

However, each file has a line specifying origin context line, such as:

    # github:norm/homedir:etc/bash/rc/filesystem.sh

If you are using [bash-composition] and retain the origin context line,
you can run the command `composition-chages` to scan your home directory,
and it will check every file it finds with an origin against the source
on GitHub. That way, if I update anything you have previously copied,
you can find out.

-- Mark Norman Francis.

[bash-composition]: https://github.com/norm/bash-composition
