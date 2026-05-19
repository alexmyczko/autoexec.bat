# set screen window name
if [[ $TERM == "screen" ]]; then
    preexec() { echo -ne "\033k$1\033\\" }
fi

if [[ $(uname) == "Darwin" ]]; then
    alias setup='/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
    alias lsusb='ioreg -p IOUSB'
    #brew install htop mc memtester ecm cmake lame lftp madplay ncdu tcc wget xz coreutils
    # disable creating .DS_store files
    #defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
    # show all files in Finder
    #defaults write com.apple.Finder AppleShowAllFiles true
    # Finder show file extensions
    #defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    #dpkg -L is brew list -v
fi
if [[ $(uname) == "Linux" ]]; then
    alias setup=''
    #systemctl disable motd-news.timer
    #systemctl disable atd
    #systemctl disable colord
    #systemctl disable bluetooth
    #systemctl disable upower
    #apt-get --purge remove ubuntu-report modemmanager whoopsie apparmor snapd bolt kerneloops
    if [ -f /usr/share/GNUstep/Makefiles/GNUstep.sh ]; then source /usr/share/GNUstep/Makefiles/GNUstep.sh; fi
fi

# far2l default arguments
FAR2L_ARGS="-an --tty"; export FAR2L_ARGS

# set favourite editor, emacs is an alternative
#EDITOR=mcedit; export EDITOR
EDITOR=vim; export EDITOR

# shell prompt
export PS1='%n@%m:%~%(!.#.$) '
unset RPS1

# if you don't want to see any deprecation warnings from Python
export PYTHONWARNINGS='ignore::PendingDeprecationWarning,ignore::DeprecationWarning'

export MANGOHUD_CONFIGFILE=~/.mangohud.conf

# history
HISTFILE=~/.history
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# debian packages
DEBEMAIL="alex@aiei.ch"; export DEBEMAIL
DEBFULLNAME="Alex Myczko"; export DEBFULLNAME

# blank and lock screen
alias xlock='xset s blank; xset s 600; xset dpms force off; i3lock -c000000'
# blank screen for wayland
alias wlock='hyprctl dispatch dpms off; read -n1; hyprctl dispatch dpms on'

# trim whitespaces
alias rtrim="sed -i 's/[ \t]*$//'"

# reboot
alias reb00t="echo 1 > /proc/sys/kernel/sysrq;echo b > /proc/sysrq-trigger"

# ls tricks
#alias ls="echo CONFIG.SYS AUTOEXEC.BAT TEMP WINDOWS My Documents PROGRA~1"

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
