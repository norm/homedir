Style guide
===========

This documents the preferred style of writing code in the home-base project,
should you want to contribute.


Optimisation
------------
All bash code is optimised _not_ for speed, but instead for legibility and
human understanding. This will never change.


Interactivity
-------------
Bash has a concept of "interactive" shells, meaning ones that have a TTY
controlling the session (in other words, with a user typing rather than being
inside an automated environment). A common optimisation in bash startups is to
immediately exit if this is the case. Unfortunately this can side-step some
useful setup actions, such as setting environment variables. In this project,
we err on the side of excess and do all setup anyway, except that which truly
makes no sense in a non-interactive session.

Any code within this project to be skipped in a non-interactive environment
should be short-circuited as early as possible with the `$must_be_interactive`
macro.

    function some_action {
        $must_be_interactive
        
        # ... do something that needs to be interactive
    }

If you need finer control, such as employing different code when running
interactively, test for it like so:

    if [ "$INTERACTIVE" -eq 1 ]; then
        # something requiring user input
    else
        # automated, default alternative
    fi


Comments
--------
Every file has a preamble comment of the form:

    # github:etc/bash/function/01.source
    # -*- Mode: Bash; tab-width: 4; indent-tabs-mode: nil; -*-
    #
    #       Extensions to the standard "source" command.

The first line documents where the file can be found on github. If the file
is in a repo other than the original (norm/home), then the user and repo 
should also appear in the line, separated by colons. For example:

    # github:norm:homedir:bin/sweep

The second line is a modeline, telling any modeline-aware text editor to use
4-character wide tabstops inserted as spaces (not tab characters). This is the
mandatory whitespace setting for any file which does not treat tabs as being a
significant character (tab-delimited files, for example).

The actual comment describing the purpose of the file is indented by two
tabstops, to allow any hanging punctuation (bullets, list numbers) to be at
the first tabstop.

Functions should have a comment before them describing their intended purpose.
This is a brief summary only, and should not been seen as user documentation.
Ideally this would be made redundant by the function having a clear,
descriptive name, but nonetheless it is still required.


Bash functions
--------------
These should be short blocks of code, with self-documenting names. Having
several short functions that together perform one action is preferable to one
long, sprawling function.

Functions used as utilities within the bash startup itself should be placed
within ~/etc/bash/function, and named with words separated by underscores.

Functions expected to be used interactively should be within ~/etc/bash/rc,
and named with words separated by hyphens (as they are easier to type, not
requiring the shift key to be held down).


Bash variables
--------------
All variables used within functions should be declared with the local keyword.
All arguments to functions ($1, $2 ...) should be unpacked into named
variables as this makes their intention and use more obvious when reading the
code.


Bash short-form if/then
-----------------------
You can write a shorter form of if/then in bash using the logical-and control
operator. This, the logical-or, and combinations of both are preferred over
the longer form for simple operations. Put each command on a line by itself,
like so:

    # example of short-form if/then/else
    [ `id -u` == '0' ]                                                  \
        && PROMPT_SYMBOLS="${PROMPT_SYMBOLS}${PROMPT_ROOTCHAR:=#}"      \
        || PROMPT_SYMBOLS="${PROMPT_SYMBOLS}${PROMPT_USERCHAR:=%}"

The then/else clause(s) should always be _one_ command only; use the long form
for multiple commands resulting from a test.
