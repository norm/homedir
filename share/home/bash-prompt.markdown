Bash prompt templates
=====================

Many people update their bash prompt to provide useful information, such as
the hostname, their username, and so on.

Something so personal does not necessarily sit well with the "generic"
framework bash startup that this project provides. So the code allows for the
prompt to be assembled from a template. `PS1` is set by `PS1_TEMPLATE`, and
so on.

The templates accept a few macros which are replaced with useful things
commonly put inside of a prompt:

* _%B_, _%b_, _%I_, %_i_, _%U_, _%u_, _%R_, _%r_, _%S_, _%s_, _%X_
  expands to the ANSI sequences for turning bold on, bold off, italic on,
  italic off, underline on, underline off, reverse on, reverse off,
  strike-through on, strike-though off, and resetting any special formatting
  back to normal.

* _%cX_, _%CX_, _%cn_, _%Cn_
  expands to the ANSI sequences for colours. %cX sets the foreground colour
  (depending upon the value of X, see colour chart below) and %cn resets it to
  normal; %CX sets the background colour and %Cn resets it to normal.
  
  * k = black
  * b = blue
  * r = red
  * m = magenta
  * g = green
  * c = cyan
  * y = yellow
  * w = white

* _%T_, _%t_
  expands to the ANSI sequences for controlling the xterm title bar. Any text
  between %T and %t will appear in the title bar rather than the prompt, if
  the terminal supports this. Also see 'Xterm titles' below.

* _[%]_
  expands to a single '%' for a normal user, and a single '#' for a root user.
  These characters can be overridden by setting PROMPT_USERCHAR and
  PROMPT_ROOTCHAR.

* _[%%]_
  expands to one or more characters as detailed above, to illustrate the 
  current shell depth. For example, upon logging into a machine this returns
  '%'. Running `bash` would then give '%%' in the subshell, and then running 
  `sudo bash` within that to get a root shell would return '%%#'.

* _[host]_
  expands to the current hostname, minus the domain. This is similar to the
  \h special character that PS1 already understands, with the difference being
  that $HOST can be set to a different value (eg. under OS X $HOST is found
  from the Sharing prefpane rather than the current output of `hostname`)
  
  The output of $HOST can be overridden by setting PROMPT_HOST. An example
  would be "%B${HOST}%b", to show the hostname in bold.

* _[user]_
  expands to the contents of $USER, if and only if the setting for $USER is
  different from $DEFAULT_USER. This can be overridden by setting PROMPT_USER.
  An example would be "%cy${USER}%cn @ " to get the user in yellow.

* _[window]_
  expands to the contents of $WINDOW, if and only if it is set. $WINDOW is
  set by `screen`. This can be overridden by setting PROMPT_WINDOW. An example
  would be "%ccin screen%cn " to show "in screen " in cyan.

* _[pwd N]_
  expands to the last N parts of the current working directory, but where
  each part is truncated to a maximum length. For example, if
  the current working directory was 
  `/Library/Application Support/CrashReporter`, the output of `[pwd 2]` would 
  be "Appl…port/Cras…rter".
  
  The length of each individual word can be controlled by setting 
  PWDN_MAX_WORD, which defaults to 10.


Xterm titles
------------
A fairly common setting for users of xterms (or xterm compatible terminals
such as PuTTY on Windows and Terminal.app on OS X) is to put special sequences
in their prompt to put information into the titlebar of the terminal.

If you are using PS1_TEMPLATE to set the main prompt, and PS1_TITLE_TEMPLATE
is set to anything, this will automatically be included in the prompt. This
allows you to use the same macros (although the ANSI formatting won't be
usable).


Default prompt
--------------
As shipped, home-base sets the following:

* PROMPT_WINDOW='%ccscr${WINDOW}%cn '
* PROMPT_USER="${USER}@"
* PS1_TEMPLATE="([window][user][host] %B[pwd 2]%b)[%%] "
* PS1_TITLE_TEMPLATE='${USER}@[host]'

The most complex prompt which would result, would look like:

    (scr2 norm@laptop Appl…port/Cras…rter)%# 


Why bother?
-----------
Yes, a lot of this can be included in the prompt without needing an
intermediary function. But which of the following code snippets would you
rather be trying to comprehend, and/or create from scratch?

    # standard bash syntax
    export PS1="\[\e0;\u@\h\007\](\[\e[33m\]\u@\h\[\e[39m\] " \
               " \[\e[1m\]\w\[\e[22m\])% "

    # home-base synxtax
    export PS1_TITLE_TEMPLATE="$USER@[host]"
    export PS1_TEMPLATE="(%cy[user][host]%cn %B[pwd 2]%b)[%] "
