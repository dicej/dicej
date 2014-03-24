# .bash_profile

BASH_PROFILE_LOADED=true

# Get the aliases and functions
if [ -z $BASHRC_LOADED ] && [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

export TERM=xterm
export JAVA_HOME=/usr/local/java
#export ANT_HOME=$HOME/p/apache-ant-1.7.1
#export ANT_OPTS="-Xmx1024m -Xss512k"

export PATH=${HOME}/trash/p/gradle-1.2/bin/:/sbin:/bin:/usr/sbin/:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/X11R6/bin:/opt/mac/bin:$HOME/.cabal/bin:/usr/lib/llvm-2.7/bin:

export GRADLE_OPTS="-Dorg.gradle.daemon=true"

#export LD_LIBRARY_PATH=/usr/local/gmp-4.3.2/lib/:/usr/local/mpfr-2.4.2/lib:/usr/local/mpc-0.8.1/lib

export MANPATH=/man:

for x in icewm vmware util emacs git java gdb mingw-w64 arm arm-oabi powerpc protobuf-2.4.1; do
  dir=/usr/local/$x
    if [ -d $dir ]; then
       if [ -d $dir/bin ]; then export PATH=$dir/bin:$PATH; fi;
       if [ -d $dir/man ]; then export MANPATH=$dir/man:$MANPATH; fi;
       if [ -d $dir/share/man ]; then export MANPATH=$dir/share/man:$MANPATH; fi;
    fi;
done

for x in apache-ant-1.7.1; do
  dir=$HOME/p/$x
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
