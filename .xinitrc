# accelerate the mouse and turn off the bell
#xset m 2 4 b off
# actually, leave the bell on (xterm and emacs can be set to 'visual bell')
#xset m 3/2 16

# use "clickfinger" instead of "buttonareas"
#xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Click Method Enabled' {0, 1}
#xinput set-prop 'Synaptics TM3289-021' 'libinput Click Method Enabled' {0, 1}

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

# Use only key pad arrow keys
# xmodmap -e 'keycode 111 ='
# xmodmap -e 'keycode 113 ='
# xmodmap -e 'keycode 114 ='
# xmodmap -e 'keycode 116 ='
# xmodmap -e 'keycode 88 = Down'
# xmodmap -e 'keycode 84 = Down'
# xmodmap -e 'keycode 83 = Left'
# xmodmap -e 'keycode 85 = Right'
# xmodmap -e 'keycode 80 = Up'

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

export QT_AUTO_SCREEN_SET_FACTOR=0
export QT_SCALE_FACTOR=1.5

xrdb -merge ~/.Xresources

# start the window manager
xsetroot -solid black
if xrandr | grep -q "DP-3 disconnected"; then
    :
else
  xrandr --output eDP-1 --mode 2256x1504 --pos 2560x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP-4 --off
fi
#xss-lock slock &

xset r rate 400 30

dbus-launch --exit-with-session ssh-agent $HOME/local/icewm/bin/icewm
