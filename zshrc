# .zshrc - amix@amix.dk 13/08/07 18:43:43
# Inspired by http://files.csa-net.dk/public/dotfiles/zshrc.txt
# Inspired by http://www.michael-prokop.at/computer/config/.zsh/
# Inspired by http://gott-gehabt.de/800_wer_wir_sind/thomas/Homepage/Computer/zsh/zshrc
umask 002

export BROWSER="/usr/bin/google-chrome %s"
export PAGER="less"
export EDITOR="vim"

export YT_DEST=$HOME/yt-x86_64/
export ARCH_PATH=$HOME/yt-x86_64/
#export ARCH_PATH=$HOME/yt-conda
export LD_LIBRARY_PATH=$ARCH_PATH/lib:/usr/local/cuda/lib64:/usr/local/cuda/lib:$LD_LIBRARY_PATH
export PATH=$ARCH_PATH/bin:$PATH
export ANDROID_SDK=/home/mturk/Android/android-sdk-linux_x86
export XUVTOP=/home/mturk/Development/chianti
export ETS_TOOLKIT=qt4
export GOROOT=/home/mturk/Development/go/
export PATH=$PATH:$HOME/Development/depot_tools/
export NACL_SDK_ROOT=$HOME/Development/nacl_sdk/pepper_canary

set -o vi

fpath=($fpath ~/.zshfuncs)
path=( /usr/local/cuda/bin $path )

path=( $path $GOROOT/bin )

# Variable settings
export SVN_EDITOR=/Users/matthewturk/.vim/svn_editor
export BZR_EDITOR=/Users/matthewturk/.vim/bzr_editor
export DYLD_LIBRARY_PATH=${S2PATH}/${S2ARCH}:/usr/local/cuda/lib

#export PYTHONPATH=$HOME/Development/crew/
alias lhg='$HOME/Development/crew/hg'

alias charm='/usr/bin/charm'

# Some virtualenv stuff
export WORKON_HOME=$HOME/Envs
alias venv='source $YT_DEST/bin/virtualenvwrapper.sh'
#source /Library/Frameworks/Python.framework/Versions/Current/bin//virtualenvwrapper_bashrc

###--------------------------------------------------
### history
HISTSIZE="50000"
HISTFILE="${HOME}/.zsh_history"
SAVEHIST="20000"
DIRSTACKSIZE=30
READNULLCMD=less

export LESSCHARSET=iso8859

alias 'localweb'='python2.7 -c "import SimpleHTTPServer, SocketServer;Handler = SimpleHTTPServer.SimpleHTTPRequestHandler;httpd = SocketServer.TCPServer((\"localhost\", 8000), Handler);httpd.serve_forever()"'
alias 'quickweb'='python2.7 -c "import SimpleHTTPServer, SocketServer;Handler = SimpleHTTPServer.SimpleHTTPRequestHandler;httpd = SocketServer.TCPServer((\"localhost\", 8000), Handler);httpd.serve_forever()"'
alias 'localweb1'='python2.7 -c "import SimpleHTTPServer, SocketServer;Handler = SimpleHTTPServer.SimpleHTTPRequestHandler;httpd = SocketServer.TCPServer((\"localhost\", 8001), Handler);httpd.serve_forever()"'
alias 'globalweb'='python -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'

cdp () {
  cd "$(python -c "import os.path as _, ${1}; \
    print _.dirname(_.realpath(${1}.__file__[:-1]))"
  )"
}

ppbr()
{
    PP="${HOME}/yt/$1/"
    if [ ! -d ${PP} ] && echo "${PP} doesn't exist" && return
    export PYTHONPATH=${PP}
    #echo "PYTHONPATH=${PYTHONPATH}"
    export YTPATH=${PP}
}
ppbr yt

cyt()
{
    [ -f ${YTPATH}/yt/utilities/command_line.py ] && python2.7 ${YTPATH}/yt/utilities/command_line.py $*
}

pdbyt()
{
    [ -f ${YTPATH}/yt/utilities/command_line.py ] && python2.7 -m pdb ${YTPATH}/yt/utilities/command_line.py $*
}

iyt()
{
    python2.7 ${YTPATH}/scripts/iyt
}

yt_lodgeit.py()
{
    python2.7 ${YTPATH}/scripts/yt_lodgeit.py $*
}

aks()
{
    keychain id_bb_dsa
    source ~/.keychain/`uname -n`-sh
}

uks()
{
    killall ssh-agent
}

ilock()
{
    killall ssh-agent
    i3lock
    sleep 10
    DISPLAY=:0.0 xset dpms force off
}

wififix()
{
    sudo iwconfig wlan0 power off
}

###--------------------------------------------------
### aliases
alias 'c'='cat'
alias 'g'='grep -i'
alias 'm'='less'
alias 'p'='pwd'
alias 'l'='ls -avFG'
alias 'ls'='ls -vG'
alias 'mk'='make'
alias 'which-command'='whence -afv'
alias 'which'='whence -afv'
alias 'pushd'='pushd;dirs -v'
alias 'popd'='podp;dirs -v'
alias 'd'='dirs -v'
alias 'j'='jobs -lp'
alias 'h'='fc -ldD -40'
alias 'svdiff'='$HOME/.vim/svn_vimdiff.sh'

###--------------------------------------------------
### options
setopt autocd autolist automenu autopushd braceccl cdablevars
setopt correct extendedglob noflowcontrol
setopt histignoredups histignorespace histnostore listtypes longlistjobs sharehistory
setopt cshnullglob magicequalsubst listpacked
setopt numericglobsort pushdignoredups pushdminus pushdsilent
setopt pushdtohome rcexpandparam rcquotes
setopt sunkeyboardhack zle nobadpattern autoremoveslash
setopt completeinword autoparamkeys
setopt alwayslastprompt

unsetopt bgnice norcs notify nonomatch hashdirs listambiguous

# Must have the zsh/termcap module loaded for this
if [[ $terminfo[colors] -ge 8 ]]; then
    local RED="%{[1;31m%}"
    local LIGHT_RED="%{[0;31m%}"
    local CYAN="%{[1;36m%}"
    local LIGHT_CYAN="%{[0;36m%}"
    local BLUE="%{[1;34m%}"
    local LIGHT_BLUE="%{[0;34m%}"
    local GREEN="%{[1;32m%}"
    local LIGHT_GREEN="%{[0;32m%}"
    local MAGENTA="%{[1;35m%}"
    local LIGHT_MAGENTA="%{[0;35m%}"
    local YELLOW="%{[1;33m%}"
    local LIGHT_YELLOW="%{[0;33m%}"
    local GRAY="%{[1;30m%}"
    local LIGHT_GRAY="%{[0;37m%}"
    local WHITE="%{[1;37m%}"
    local NO_COLOUR="%{[0m%}"
    local BEGINNING_OF_LINE="%{[80D%}"
else
    local RED=""
    local LIGHT_RED=""
    local CYAN=""
    local LIGHT_CYAN=""
    local BLUE=""
    local LIGHT_BLUE=""
    local GREEN=""
    local LIGHT_GREEN=""
    local MAGENTA=""
    local LIGHT_MAGENTA=""
    local YELLOW=""
    local LIGHT_YELLOW=""
    local GRAY=""
    local LIGHT_GRAY=""
    local WHITE=""
    local NO_COLOUR=""
    local BEGINNING_OF_LINE=""
fi


###--------------------------------------------------
### prompts
PROMPT="%(?..(${RED}{%?}${NO_COLOUR}%))[${YELLOW}%T${NO_COLOUR}][${CYAN}%15<...<%~${NO_COLOUR}]$ "

unset P


### COMPLETION AND MORE

# The following lines were added by compinstall
[[ -z $fpath[(r)$_compdir] ]] && fpath=($fpath $_compdir)
#fpath=(/home/tkoehler/zsh/foo $fpath)

autoload -U compinit
compinit

local _myhosts
_myhosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*})
# zstyle ':completion:*' hosts $_myhosts

zstyle ':completion:*' auto-description 'specify %d'
zstyle ':completion:*' completer _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' group-name ''
## domains to use for mutt user@host<TAB> completion
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list 'r:|[._-]=** r:|=**' 'l:|=* r:|=*' 'm:{a-z}={A-Z}'
zstyle ':completion:*' match-original both
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=0
zstyle ':completion:*' prompt 'CORRECT (%e errors found) > '
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle '*mutt*' users vim vim-dev tkoehler
zstyle '*' users thomas tkoehler
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/tkoehler/.zshrc'
# End of lines added by compinstall
#fpath=(/usr/share/doc/zsh/examples/Functions/Misc/ $fpath)
#autoload nslookup


zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:*:*:hosts' list-colors '=(#b)(*)(to.com)=34;40=35;40' '=(#b)(*)(mayn.de)=36;40=35;40' '=unser.linux.laeuft.auf.s390.org=33;40' '=*=31;40'
zstyle ':completion:*:*:*:*:users' list-colors '=*=32;40'

autoload -U zfinit
zfinit

ZLS_COLOURS='ma=7:di=0:ex=0:bd=0:cd=0:ln=0:so=0'

### KEY BINDINGS
# vi keybindings
bindkey -v

bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward
bindkey "[C" forward-char
bindkey "[D" backward-char
bindkey "^Xq" push-line
bindkey "^Xr" history-incremental-search-backward
bindkey "^Xs" history-incremental-search-forward
bindkey "^X_" insert-last-word
bindkey "^Xa" accept-and-hold
bindkey "^X^H" run-help
bindkey "^Xh" _complete_help
bindkey "^I" expand-or-complete
bindkey "^E" expand-word
bindkey -M vicmd "^R" redo
bindkey -M vicmd "u" undo
bindkey -M vicmd "ga" what-cursor-position

### VI MODE EXTENSIONS
redisplay() {
   builtin zle .redisplay
   ( true ; show_mode "insert") &!
}
redisplay2() {
   builtin zle .redisplay
   (true ; show_mode "normal") &!
}
zle -N redisplay
zle -N redisplay2
bindkey -M viins "^X^R" redisplay
bindkey -M vicmd "^X^R" redisplay2

screenclear () {
   echo -n "\033[2J\033[400H"
   builtin zle .redisplay
   (true ; show_mode "insert") &!
}
zle -N screenclear
bindkey "" screenclear

screenclearx () {
   # print -n '7'
   repeat 2 print 
   local MYLINE="$LBUFFER$RBUFFER"
   highlight $MYLINE
   repeat 4 print 
   builtin zle redisplay
}
zle -N screenclearx
bindkey "^Xl" screenclearx

show_mode() {
   local COL
   local x
   COL=$[COLUMNS-3]
   COL=$[COL-$#1]
   x=$(echo $PREBUFFER | wc -l )
   x=$[x+1]
   echo -n "7[0;$COL;H"
   echo -n ""

   if [[ $1 = insert ]]; then
       echo -n "[0;37;41m Insert [0m"
   fi
   if [[ $1 = normal ]]; then
       echo -n "[0;37;44m Normal [0m"
   fi
   if [[ $1 = replace ]]; then
       echo -n "[0;37;46m Replace [0m"
   fi
   echo -n "8"
}

###       vi-add-eol (unbound) (A) (unbound)
###              Move  to the end of the line and enter insert mode.
vi-add-eol() {
   show_mode "insert"
   builtin zle .vi-add-eol
}
zle -N vi-add-eol
bindkey -M vicmd "A" vi-add-eol

###       vi-add-next (unbound) (a) (unbound)
###              Enter insert mode after the  current  cursor  posi­
###              tion, without changing lines.
vi-add-next() {
   show_mode "insert"
   builtin zle .vi-add-next
}
zle -N vi-add-next
bindkey -M vicmd "a" vi-add-next

###       vi-change (unbound) (c) (unbound)
###              Read a movement command from the keyboard, and kill
###              from  the  cursor  position  to the endpoint of the
###              movement.  Then enter insert mode.  If the  command
###              is vi-change, change the current line.

vi-change() {
   show_mode "insert"
   builtin zle .vi-change
}
zle -N vi-change
bindkey -M vicmd "c" vi-change

###       vi-change-eol (unbound) (C) (unbound)
###              Kill  to the end of the line and enter insert mode.
vi-change-eol() {
   show_mode "insert"
   builtin zle .vi-change-eol
}
zle -N vi-change-eol
bindkey -M vicmd "C" vi-change-eol

###       vi-change-whole-line (unbound) (S) (unbound)
###              Kill the current line and enter insert mode.
vi-change-whole-line() {
   show_mode "insert"
   builtin zle .vi-change-whole-line
}
zle -N vi-change-whole-line
bindkey -M vicmd "S" vi-change-whole-line

###       vi-insert (unbound) (i) (unbound)
###              Enter insert mode.
vi-insert() {
   show_mode "insert"
   builtin zle .vi-insert
}
zle -N vi-insert
bindkey -M vicmd "i" vi-insert

###       vi-insert-bol (unbound) (I) (unbound)
###              Move to the first non-blank character on  the  line
###              and enter insert mode.
vi-insert-bol() {
   show_mode "insert"
   builtin zle .vi-insert-bol
}
zle -N vi-insert-bol
bindkey -M vicmd "I" vi-insert-bol

###       vi-open-line-above (unbound) (O) (unbound)
###              Open a line above the cursor and enter insert mode.
vi-open-line-above() {
   show_mode "insert"
   builtin zle .vi-open-line-above
}
zle -N vi-open-line-above
bindkey -M vicmd "O" vi-open-line-above

###       vi-open-line-below (unbound) (o) (unbound)
###              Open a line below the cursor and enter insert mode.
vi-open-line-below() {
   show_mode "insert"
   builtin zle .vi-open-line-below
}
zle -N vi-open-line-below
bindkey -M vicmd "o" vi-open-line-below

###       vi-substitute (unbound) (s) (unbound)
###              Substitute the next character(s).
vi-substitute() {
   show_mode "insert"
   builtin zle .vi-substitute
}
zle -N vi-substitute
bindkey -M vicmd "s" vi-substitute


###       vi-replace (unbound) (R) (unbound)
###              Enter overwrite mode.
###
vi-replace() {
   show_mode "replace"
   builtin zle .vi-replace
}
zle -N vi-replace
bindkey -M vicmd "R" vi-replace

###       vi-cmd-mode (^X^V) (unbound) (^[)
###              Enter  command  mode;  that  is, select the `vicmd'
###              keymap.  Yes, this is bound  by  default  in  emacs
###              mode.
vi-cmd-mode() {
   show_mode "normal"
   builtin zle .vi-cmd-mode
}
zle -N vi-cmd-mode
bindkey -M viins "" vi-cmd-mode


###       vi-oper-swap-case
###              Read a movement command from the keyboard, and swap
###              the case of all characters from the cursor position
###              to the endpoint of the movement.  If  the  movement
###              command  is vi-oper-swap-case, swap the case of all
###              characters on the current line.
###
bindkey -M vicmd "g~" vi-oper-swap-case
