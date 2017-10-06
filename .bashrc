# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

BASHRC_LOADED=true

shopt -s checkwinsize
shopt -s histappend

# Get the aliases and functions
if [ -z $BASH_PROFILE_LOADED ] && [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi

alias x=startx

#alias ls='ls --color'
alias ll='ls -l'
alias lh='ls -lh'

alias ssh='ssh -t -q'

alias ant='ant -emacs'
alias ag='sudo apt-get'
alias ac='apt-cache'

alias em="emacs -q -nw -l ${HOME}/.emacs";
alias e="emacsclient -nw";
alias se="sudo emacs -q -nw -l ${HOME}/.emacs";

alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.5-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java org.antlr.v4.gui.TestRig'

function sp {
    echo "$@" | ispell -a
}

# List of color variables that bash can use

   C1="\[\033[0;30m\]" # Black
   C2="\[\033[1;30m\]" # Dark Gray
   C3="\[\033[0;31m\]" # Red
   C4="\[\033[1;31m\]" # Light Red
   C5="\[\033[0;32m\]" # Green
   C6="\[\033[1;32m\]" # Light Green
   C7="\[\033[0;33m\]" # Brown
   C8="\[\033[1;33m\]" # Yellow
   C9="\[\033[0;34m\]" # Blue
   C10="\[\033[1;34m\]" # Light Blue
   C11="\[\033[0;35m\]" # Purple
   C12="\[\033[1;35m\]" # Light Purple
   C13="\[\033[0;36m\]" # Cyan
   C14="\[\033[1;36m\]" # Light Cyan
   C15="\[\033[0;37m\]" # Light Gray
   C16="\[\033[1;37m\]" # White
   P="\[\033[0m\]" # Neutral

# bash prompt

#   PS1="\w$P$C4 $ $C4$P"
#   PS1="$P$C9[\w]$C9$P\n$P$C10 $ $C10$P"
#   PS1="$P$C4 \247 $C4$P"
   if [ "$(hostname)" != "joeldicepc" ]; then
       PS1="\\[\\033]0;\h::\\w\\007$C4 \h: $P";
   else
     if [ -z "$DISPLAY" ]; then
       PS1=" $ "
     else
       PS1="\\[\\033]0;::\\w\\007$C4 $ $P";
     fi
   fi
#PS1="\\[\\033]0;::\\w\\007$C10:: $P"

PROMPT_COMMAND="history -a;"

#echo sourced ~/.bashrc

export NVM_DIR="/home/dicej/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -s "/home/dicej/.gvm/scripts/gvm" ]] && source "/home/dicej/.gvm/scripts/gvm"
