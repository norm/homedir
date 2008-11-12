# ~/.bash/host/yahoo.com

[ -n "$YROOT_NAME" ]    &&  prompt_prefix="${yellow}${YROOT_NAME}${reset}"

[ -d /home/y/bin/ ]     &&  PATH="$PATH:/home/y/bin"
