# set screen window name
if [[ $TERM == "screen" ]]; then
    preexec() { echo -ne "\033k$1\033\\" }
fi

if [[ $(uname) == "Darwin" ]]; then
    alias setup='/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
    #brew install htop mc memtester ecm cmake lame lftp madplay ncdu tcc wget xz
    # disable creating .DS_store files
    #defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
    # show all files in Finder
    #defaults write com.apple.Finder AppleShowAllFiles true
    # Finder show file extensions
    #defaults write NSGlobalDomain AppleShowAllExtensions -bool true
fi
if [[ $(uname) == "Linux" ]]; then
    alias setup=''
    #systemctl disable motd-news.timer
    #apt-get --purge remove ubuntu-report
    if [ -f /usr/share/GNUstep/Makefiles/GNUstep.sh ]; then source /usr/share/GNUstep/Makefiles/GNUstep.sh; fi
fi

# set favourite editor, emacs is an alternative
EDITOR=mcedit; export EDITOR

# shell prompt
export PS1='%n@%m:%~%(!.#.$) '
unset RPS1

# history
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.history

# debian packages
DEBEMAIL="alex@aiei.ch"; export DEBEMAIL
DEBFULLNAME="Alex Myczko"; export DEBFULLNAME

# ls tricks
alias ls="echo CONFIG.SYS AUTOEXEC.BAT TEMP WINDOWS My Documents PROGRA~1"
