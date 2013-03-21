#===============================================================
#
# PERSONAL $HOME/.bashrc FILE for bash-2.05a (or later)
# Last modified: Fri Dec 03 19:12:34 PST 2010
#
#===============================================================

# Add /usr/local/sbin to the PATH
export PATH=/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/var/lib/gitolite/bin

# Add Android tools to the PATH
export PATH=$PATH:$HOME/pentest/mobile/android-sdk-macosx/tools
export PATH=$PATH:$HOME/pentest/mobile/android-sdk-macosx/platform-tools

# git bash completion
source /usr/local/Cellar/git/1.7.10.1/etc/bash_completion.d/git-completion.bash
# brew bash completion
source /usr/local/Library/Contributions/brew_bash_completion.sh

# Color settings
export CLICOLOR=1
export TERM=xterm-256color
export LSCOLORS=gxhxxxxxfxcxcxbxdxxxxx

# Prompt settings
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# Some settings
set -o notify
shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s dotglob
shopt -s cmdhist
shopt -s extglob

# Aliases
alias ll='ls -lF'
alias la='ls -alF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias grep='grep --color=auto'
alias type='type -all'
alias path='echo $PATH'
alias savescreen='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine'
alias brb='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine'
alias ts='date -j -f "%a %b %d %T %Z %Y" "`date`" "+%s"'

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }

# Recursively grep for a pattern
function gg() { grep -irn $1 ./ 2> /dev/null ; }

# Network related functions
function my_ip() # Get wireless IP adresses
{
	MY_IPW=$(/sbin/ifconfig en2 | grep -v inet6 | awk '/inet/ { print $2 }')
	MY_IPL=$(/sbin/ifconfig en0 | grep -v inet6 | awk '/inet/ {print $2}')
}

function ip() # Print wireless IP address.
{
	/sbin/ifconfig en0 | grep -v inet6 | awk '/inet/ {print $2}'
	/sbin/ifconfig en2 | grep -v inet6 | awk '/inet/ { print $2 }'
}


# Get current host related info.
function ii()
{
	echo -e "\nYou are logged on \033[0;36m$HOSTNAME\033[0m"
	echo -e "\nAdditionnal information:$NC" ; uname -a
	echo -e "\n\033[0;36mUsers logged on:$NC\033[0m" ; w -h
	echo -e "\n\033[0:36mCurrent date :$NC\033[0m" ; date
	echo -e "\n\033[0:36mMachine stats :$NC\033[0m" ; uptime
	echo -e "\n\033[0:36men0 IP Address :$NC\033[0m" ; echo ${MY_IPL:-"Not connected"}
	echo -e "\n\033[0:36men1 IP Address :$NC\033[0m" ; echo ${MY_IPW:-"Not connected"}
	echo
}
	
# Set runtime environment
my_ip 2>&- ;

# load isec specifics (si opus sit)
if [ -f "$HOME/.isecrc" ]; then
  . "$HOME/.isecrc"
fi
