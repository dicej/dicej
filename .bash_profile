# .bash_profile

BASH_PROFILE_LOADED=true

# Get the aliases and functions
if [ -z $BASHRC_LOADED ] && [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

export GPG_TTY=$(tty)
export TERM=xterm

export PATH=${HOME}/Downloads/zig-linux-x86_64-0.11.0:/usr/bin:/snap/bin::/sbin:/bin:/usr/sbin/:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/X11R6/bin:${HOME}/bin:${HOME}/.local/bin

export MANPATH=/man:

for x in icewm; do
  dir=/usr/local/$x
    if [ -d $dir ]; then
       if [ -d $dir/bin ]; then export PATH=$dir/bin:$PATH; fi;
       if [ -d $dir/man ]; then export MANPATH=$dir/man:$MANPATH; fi;
       if [ -d $dir/share/man ]; then export MANPATH=$dir/share/man:$MANPATH; fi;
    fi;
done

export EDITOR="emacs -q -nw -l ${HOME}/.emacs"

export BASH_ENV=$HOME/.bashrc
export PYTHONPATH=$HOME/.python
export RSYNC_RSH=ssh

export HISTSIZE=1000000

unset USERNAME

# report status of terminated bg jobs immediately
set -b
if [ -e /home/dicej/.nix-profile/etc/profile.d/nix.sh ]; then . /home/dicej/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

. "$HOME/.cargo/env"
