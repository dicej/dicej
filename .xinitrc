# accelerate the mouse and turn off the bell
#xset m 2 4 b off
# actually, leave the bell on (xterm and emacs can be set to 'visual bell')
xset m 3/2 16

# use "clickfinger" instead of "buttonareas"
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Click Method Enabled' {0, 1}

# make Caps Lock another Ctrl key
xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e 'add Control = Caps_Lock'
xmodmap -e 'keycode 66 = Control_L'
# for training purposes:
#xmodmap -e 'remove Control = Control_L'

xmodmap -e 'keycode 133 = Control_L'
xmodmap -e 'remove mod4 = Control_L'
xmodmap -e 'add Control = Control_L'
xmodmap -e 'keycode 134 = Control_R'
xmodmap -e 'remove mod4 = Control_R'
xmodmap -e 'add Control = Control_R'

#xmodmap -e 'keycode 115 = Control_L'
#xmodmap -e 'add Control = Control_L'
#xmodmap -e 'keycode 116 = Control_R'
#xmodmap -e 'add Control = Control_R'

#xclock -d -brief -geometry -0-0 -padding 3 -bg black -fg white &

# japanese
#kinput2 -canna &

# show a picture in the root window
# display.sh &

# xdm doesn't source it, so we do it here explicitly
#if [ ! $PROFILE_SOURCED ]; then source $HOME/.bash_profile; fi
# also, debian xdm runs xconsole, which we don't like
#sudo killall xconsole

# start the window manager
xsetroot -solid black
if xrandr | grep "HDMI-1 disconnected"; then
    :
else
  xrandr --output HDMI-1 --primary --left-of eDP-1
  xrandr --output eDP-1 --pos 1920x120
fi
xss-lock slock &
ssh-agent /home/dicej/local/icewm/bin/icewm
