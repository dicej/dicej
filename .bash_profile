# .bash_profile

BASH_PROFILE_LOADED=true

# Get the aliases and functions
if [ -z $BASHRC_LOADED ] && [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

export GPG_TTY=$(tty)
export TERM=xterm
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
#export ANT_HOME=$HOME/p/apache-ant-1.7.1
#export ANT_OPTS="-Xmx1024m -Xss512k"

export PATH=/usr/bin:/snap/bin:${HOME}/Downloads/FlameGraph:${HOME}/Qt5.10.0/Tools/QtCreator/bin:${HOME}/Downloads/node-v10.15.0-linux-x64/bin:${HOME}/trash/depot_tools:${HOME}/trash/p/gradle-1.2/bin/:/sbin:/bin:/usr/sbin/:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/X11R6/bin:/opt/mac/bin:$HOME/.cabal/bin:/usr/lib/llvm-2.7/bin:${HOME}/.local/bin:${HOME}/bin:${HOME}/Android/Sdk/platform-tools:
#$HOME/Android/Sdk/ndk-bundle/toolchains/llvm/prebuilt/linux-x86_64/bin:$HOME/Downloads/depot_tools/:

export ANDROID_HOME=${HOME}/Android/Sdk/

export CLASSPATH=".:/usr/local/lib/antlr-4.5.2-complete.jar"

export GRADLE_OPTS="-Dorg.gradle.daemon=true"

#export LD_LIBRARY_PATH=${HOME}/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib
#export LD_LIBRARY_PATH=/usr/local/gmp-4.3.2/lib/:/usr/local/mpfr-2.4.2/lib:/usr/local/mpc-0.8.1/lib

export MANPATH=/man:

for x in icewm vmware util emacs git java gdb mingw-w64 arm arm-oabi powerpc protobuf-2.4.1 iojs-v3.2.0-linux-x64 ghc-8.0.2; do
  dir=/usr/local/$x
    if [ -d $dir ]; then
       if [ -d $dir/bin ]; then export PATH=$dir/bin:$PATH; fi;
       if [ -d $dir/man ]; then export MANPATH=$dir/man:$MANPATH; fi;
       if [ -d $dir/share/man ]; then export MANPATH=$dir/share/man:$MANPATH; fi;
    fi;
done

for x in gcc-5.3.0; do
  dir=$HOME/trash/$x/install
    if [ -d $dir ]; then
       if [ -d $dir/bin ]; then export PATH=$dir/bin:$PATH; fi;
       if [ -d $dir/man ]; then export MANPATH=$dir/man:$MANPATH; fi;
       if [ -d $dir/share/man ]; then export MANPATH=$dir/share/man:$MANPATH; fi;
       if [ -d $dir/lib64 ]; then export LD_LIBRARY_PATH=$dir/lib64:$LD_LIBRARY_PATH; fi;
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

export PATH="$HOME/.cargo/bin:$PATH"
