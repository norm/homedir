# github:norm/homedir:etc/bash/rc/processes.sh
#
# Process manipulation.

ps_title='USER               PID  PPID CPU NI STAT COMMAND'
ps_flags='user,pid,ppid,cpu,nice,state,command'

alias ps='ps wwwax -o ${ps_flags}'
alias psg='echo "${ps_title}"; ps | egrep -i'

alias stop='sudo kill -STOP'
alias cont='sudo kill -CONT'

alias j='jobs -l'
