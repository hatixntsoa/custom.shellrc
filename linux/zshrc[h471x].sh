### Powerlevel10k Theme

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Make zsh instant prompt quiet
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

#######################################################################

### ZSH Basic Config

set autocd         # change directory just by typing his name
setopt promptsubst # enable command substitution in prompt

# configure keybindings
bindkey -e # emacs keybindings
bindkey ' ' magic-space # do history expansion on space

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

#######################################################################

### oh-my-zsh Config

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Oh-My-Zsh custom theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  web-search
  vscode
  sudo
)

# Here to disable oh-my-zsh auto update
DISABLE_AUTO_UPDATE="true"

# This is for fastfile Oh-My-Zsh Plugin
fastfile_var_prefix='$'

# Declare the variable for zsh-syntax-highlighting styles
typeset -A ZSH_HIGHLIGHT_STYLES

# From ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/highlighters/main/README.md
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg='#ffffff'
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg='none'
ZSH_HIGHLIGHT_STYLES[precommand]=fg='none'
ZSH_HIGHLIGHT_STYLES[arg0]=fg='none'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg='#23ff45'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg='#23ff45'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#37b0ff,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#37b0ff,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#ffe541,bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#ff9000,bold'
ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=#d30ccf,bold'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#d30ccf,bold'

# here the color of the auto-suggestion
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=#0000ff"

# source oh-my-zsh after everything have been loaded
source $ZSH/oh-my-zsh.sh

#######################################################################

### ANSI CODES VARIABLES

# Text Color
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
LIGHT_GRAY="\e[37m"
DARK_GRAY="\e[90m"
LIGHT_RED="\e[91m"
LIGHT_GREEN="\e[92m"
LIGHT_YELLOW="\e[93m"
LIGHT_BLUE="\e[94m"
LIGHT_MAGENTA="\e[95m"
LIGHT_CYAN="\e[96m"
# WHITE="\e[97m"
WHITE="\e[38;2;201;209;217m"

# Background Color
BG_BLACK="\e[40m"
BG_RED="\e[41m"
BG_GREEN="\e[42m"
BG_YELLOW="\e[43m"
BG_BLUE="\e[44m"
BG_MAGENTA="\e[45m"
BG_CYAN="\e[46m"
BG_LIGHT_GRAY="\e[47m"
BG_DARK_GRAY="\e[100m"
BG_LIGHT_RED="\e[101m"
BG_LIGHT_GREEN="\e[102m"
BG_LIGHT_YELLOW="\e[103m"
BG_LIGHT_BLUE="\e[104m"
BG_LIGHT_MAGENTA="\e[105m"
BG_LIGHT_CYAN="\e[106m"
BG_WHITE="\e[107m"

# Text Style
BOLD="\e[1m"
DIM="\e[2m"
UNDERLINE="\e[4m"
BLINK="\e[5m"
INVERT="\e[7m"
HIDDEN="\e[8m"

# Reset
RESET="\e[0m"
RESETBG="\e[49m\n"

# Character
CHECKMARK="$(printf '\xE2\x9C\x94')"
QUESTION_MARK="$(printf '\xE2\x9D\x93')"

#######################################################################

### Basic Aliases

# this alias to update the package
alias upd="allow_sudo && upd"

# this function for up alias
function upd(){
  echo "u p d a t i n g .  .  ." | figlet -t -c;
  br && sudo apt update && br;
}

# this alia to update the package
alias upg="allow_sudo && upg"

# this function for up alias
function upg(){
  echo "u p g r a d i n g . . ." | figlet -t -c;
  br && sudo apt upgrade && br;
}

# this alias to install package
alias ist="allow_sudo && ist"

# this function for ist alias
function ist(){
  case "${1##*.}" in
    git)
      echo "   C l o n i n g .  .  . " | figlet;
      br && echo "Package =======> "${1%.*}" ";
      br && git clone "$1" && br;
      ;;
    *)
      echo "   I n s t a l l i n g .  .  . " | figlet;
      c && br && echo "Package =======> "$1" ";
      br && sudo apt install "$1" && br;
      ;;
  esac
}

# this alias to install package
alias rmv="rmv"

# this function for ist alias
function rmv(){
  case "${1##*.}" in
    deb)
      c && echo -e && echo -e && sudo clear && echo -e && echo -e && echo "   r e m o v i n g .  .  . " | figlet | lolcat && echo -e && echo "Package =======> "${1%.*}" " && echo -e && sudo dpkg -r "$1" && echo -e;
      ;;
    *)
      c && echo -e && echo -e && sudo clear && echo -e && echo -e && echo "   r e m o v  i n g .  .  . " | figlet | lolcat && echo -e && echo "Package =======> "$1" " && echo -e && sudo apt remove "$1" && echo -e;
      ;;
  esac
}

# this alias to rename a file / directory; and display it after
alias nm="nm"

# this function for cpf alias
function nm(){
  mv "$1" "$2" && cv;
}

# this line to count line inside a file
alias cl="linecount"

# this function for the cl alias
function linecount() {
  if [ -z "$1" ]; then
      echo "Please provide a filename"
  elif [ -z "$2" ]; then
      wc -l "$1" | awk '{print $1, "lines"}'
  else
      grep -c "$1" "$2" | awk -v var="$1" '{print $1, var, "in it"}'
  fi
};

# this line to view a command manual
alias mn="mn"

# this function for mn alias
function mn(){
  if [[ $# -eq 1 ]]; then
    man $1 | less
  else
    man $1 | grep $2 | less
  fi
}

# this alias to view tthe manual entry for a command
alias mns="mns"

# this function for mn alias
function mns(){
  if [[ $(command -v "$1") ]]; then
    local manual_path=~/NTSOA/manual
    # here to check if the command exists
    man "$1" | cat > $manual_path/"$1"_manual.txt;
    all $manual_path/"$1"_manual.txt;
    vf $manual_path/"$1"_manual.txt;
    cv;
  else
    cv
  fi
}

# this alias to enter the manual directory
alias mnv="mnv"

# this function for mnv alias
function mnv(){
  if [[ $# -eq 0 ]]; then
    op /home/h471x/NTSOA/manual;
  elif [[ $# -eq 1 ]]; then
    op /home/h471x/NTSOA/manual "$1";
  fi
}

# this alias to view the pc state
alias pc="c && br 2 && neofetch --source ~/.config/neofetch/htx2.txt"

# this alias to view the history
alias hst="hst"

# this function for hst alias
function hst(){
  if [[ $# -eq 0 ]]; then
    history | less && cv
  else
    re='^[0-9]+$'
    # check if the argument is an integrer
    if [[ $1 =~ $re ]]; then
      history | tail -$1 | less && cv
    else  # else if it's a text to grep
      history | grep "$1" | less && cv
    fi
  fi
}

# this alias to specify which command in the history to search
alias hsg="hsg"

# this function for hsg alias
function hsg(){
  if [[ $# -eq 0 ]]; then
    history | less && cv;
  else
    history | grep "$1" | less && cv;
  fi
}

# this alias to count line and words inside a file
alias flc="flc"

# this function for the cl alias
function flc(){
  if [[ -f "$1" ]]; then
    if [ -z "$1" ]; then
      echo "Please provide a filename"
    elif [ -z "$2" ]; then
      c && br;
      echo -ne " ==> "
      file "$1";
      echo -ne " ==> ";
      wc -l "$1" | awk '{print $1, "lines"}';
      echo -ne " ==> ";
      wc -w "$1" | awk '{print $1, "words"}';

      # Display the file size using Bash arithmetic
      file_size=$(stat -c%s "$1")
      if (( file_size < 1024 )); then
        echo " ==> Size : $file_size bytes"
      elif (( file_size < 1048576 )); then
        size_kb=$(awk "BEGIN {printf \"%.2f\", $file_size/1024}")
        echo " ==> Size : $size_kb KB"
      elif (( file_size < 1073741824 )); then
        size_mb=$(awk "BEGIN {printf \"%.2f\", $file_size/1048576}")
        echo " ==> Size : $size_mb MB"
      else
        size_gb=$(awk "BEGIN {printf \"%.2f\", $file_size/1073741824}")
        echo " ==> Size : $size_gb GB"
      fi

      br;
    else
      grep -c "$1" "$2" | awk -v var="$1" '{print $1, var, "in it"}'
    fi
  elif [[ -d "$1" ]]; then
    dc "$1";
  fi
}

# this alias to list
alias list="list"

# this function for list alias
function list(){
  local list_app="eza --icons=always --no-quotes"
  eval $list_app
}

# this alias to save a file content to another file
alias sv="sv"

# this function for sv alias
function sv(){
  cat "$1" > "$2";
}

# this alias to clear
alias c="clear"

# this alias to clear but with extra lines
alias x="clear && echo -e && echo -e && echo -e && echo -e && echo -e && echo -e"

# this alias to break a line
alias br="br"

# this function for br alias
function br(){
  if [[ $# -eq 1 ]]; then
    for ((i=1; i<=$1;i++)); do
      echo -e;
    done
  elif [[ $# -eq 0 ]]; then
    echo -e;
  fi
}

# this alias to show the welcome message
alias cvi="cvii"

# here to write a welcome message
function cvii(){
  clear && br 2;
  echo "H    4    7    1    X" | figlet -t -c;
  br 2;
}

x;

# this alias to exit
alias q='exit'

# this alias to give full permission
alias all="all"

# this function for all alias
function all(){
  if [[ $# -eq 0 ]]; then
    if [[ -d "$1" ]]; then
      chmod 700 * && cv;
    elif [[ -f "$1" ]]; then
      chmod 777 * && cv;
    fi
  else
    if [[ -d "$1" ]]; then
      chmod 700 "$@" && cv;
    elif [[ -f "$1" ]]; then
      chmod 777 "$@" && cv;
    fi
  fi
}

#######################################################################

### Navigation Aliases

# this alias to have the current view
# of working directory content using ls
alias cv="cv"

# this function for cv alias
# UPDATED : 01/25/2024
# to adjust the title
# when we have more than 50 visible items
function cv {
  local target="$1"
  local folder_content="${target:-$PWD}"
  local folder_name=$(basename $folder_content)
  local visible_item=$(ls $folder_content | wc -l)
  local total_item=$(ls -A $folder_content | wc -l)
  local hidden_item=$((total_item - visible_item))

  # this function for the header of cv alias
  function show_header {
    local folder_header
    if [[ $total_item -eq 0 ]]; then
      folder_header="Empty(0)";
      folder_icon=" "
    elif [[ $hidden_item -eq 0 ]]; then
      folder_header="total($visible_item)";
      folder_icon=" "
    else
      folder_header="visible($visible_item) hidden($hidden_item) total($total_item) ";
      folder_icon=" "
    fi
    echo "${BOLD}${WHITE} $folder_icon $folder_name -> $folder_header ${RESET}";
  }

  # this function to show the content of the cv
  function show_content {
    if command -v eza >/dev/null 2>&1; then
      eza --icons=always --no-quotes --group-directories-first $folder_content
    else
      ls $folder_content
    fi
  }

  # this function to show the all of the cv content
  function show_all {
    c && br;

    if [[ $visible_item -lt 30 ]]; then
      show_header;
      br;
      show_content;
      br;
    else
      show_content;
      br 2;
      show_header;
      br;
    fi
  }
  show_all;
}

# this alias to view the current directory content
alias cvf="cvf"

# this function for cvf alias
# UPDATED : 01/25/2024
# to adjust the title
# when we have more than 50 visible items
function cvf {
  local target="$1"
  local folder_content="${target:-$PWD}"
  local folder_name=$(basename $folder_content)
  local visible_item=$(ls $folder_content | wc -l)
  local total_item=$(ls -A $folder_content | wc -l)
  local hidden_item=$((total_item - visible_item))

  # this function for the header of cv alias
  function show_header {
    local folder_header
    if [[ $total_item -eq 0 ]]; then
      folder_header="Empty(0)";
      folder_icon=" "
    elif [[ $hidden_item -eq 0 ]]; then
      folder_header="total($visible_item)";
      folder_icon=" "
    else
      folder_header="visible($visible_item) hidden($hidden_item) total($total_item) ";
      folder_icon=" "
    fi
    echo "${BOLD}${WHITE} $folder_icon $folder_name -> $folder_header ${RESET}";
  }

  # this function to show the content of the cv
  function show_content {
    if command -v eza >/dev/null 2>&1; then
      eza --icons=always --no-quotes -a --group-directories-first $folder_content;
    else
      ls -A $folder_content
    fi
  }

  # this function to show the cv
  function show_all {
    c && br;

    if [[ $hidden_item -lt 30 ]]; then
      show_header;
      br;
      show_content;
      br;
    else
      show_content;
      br 2;
      show_header;
      br;
    fi
  }
  show_all;
}

# this alias to view the current directory content
# with specifications
alias cvg="cvg"

# this function for cvg alias
function cvg {
  local folder_name=$(basename $PWD)
  local item="$1"
  local matched_items=$(ls -A | grep "$item" | wc -l)

  function show_header {
    echo "${BOLD}   $folder_name -> contains $matched_items '$1' ${RESET}";
  }

  function show_content {
    if command -v eza >/dev/null 2>&1; then
      eza --icons=always --color=always -a --group-directories-first | grep "$1";
    else
      ls -A | grep "$1"
    fi
  }

  # this function to show the cv
  function show_all {
    c && br;

    if [[ $matched_items -lt 20 ]]; then
      show_header $1; br;
      show_content $1; br;
    else
      show_content $1; br;
      show_header $1;
    fi
  }
  show_all $item;
}

# this alias to use batcat as bat
alias bat="batcat"

# this alias to copy terminal
# outputs to clipboard
function copy_clipboard {
  xsel --input --clipboard < "$1"
}

# function to copy files or directories
function copy_file {
  local src="$1"
  local dest="$2"
  shift 2

  if command -v rsync >/dev/null 2>&1; then
    rsync -av --progress "$src" "$dest" "$@"
  else
    cp -rv "$@" "$src" "$dest"
  fi
}

# this to interact with clipboard
function copy {
  if [[ "$#" -le 1 ]]; then
    copy_clipboard "$@"
  elif [[ "$#" -ge 2 ]]; then
    local src="$1"
    local dest="$2"
    shift 2

    copy_file "$src" "$dest" "$@"
  else
    echo "copy - copy to clipboard or files"
    echo
    echo "Usage : "
    echo "- echo test | copy"
    echo "- copy file destination"
  fi
}

# this alias to paste from clipboard
alias paste="xsel --output --clipboard"

# this alias to use python3 when typing python
alias python="python3"

# this alias to push to pypi
alias pypush="pypush"

# this function for pypush alias
function pypush {
  local token_path=/home/h471x/NTSOA/credentials/pypi_h471x_token
  local TWINE_USERNAME=__token__
  local TWINE_PASSWORD=$(cat $token_path)
  twine upload --username $TWINE_USERNAME --password $TWINE_PASSWORD dist/*
}

# this alias to use pip3 when typing pip
alias pip="pip3"

# this alias to open a directory
alias op="op"

# this function for op alias
function op() {
  # Check if $1 is a symbolic link
  if [[ -L "$1" ]]; then
    # Resolve the real path of the symbolic link
    real_path=$(readlink -f "$1")
    # Check if the resolved path is a directory
    if [[ -d "$real_path" ]]; then
      if [[ $# -eq 1 ]]; then
        cd "$real_path" && cv
      elif [[ $# -eq 2 ]]; then
        cd "$real_path" && cvg "$2"
      fi
    # Check if the resolved path is a file
    elif [[ -f "$real_path" ]]; then
      vf "$real_path"
    fi
  # If $1 is a directory (but not a symbolic link)
  elif [[ -d "$1" ]]; then
    if [[ $# -eq 1 ]]; then
      cd "$1" && cv
    elif [[ $# -eq 2 ]]; then
      cd "$1" && cvg "$2"
    fi
  # If $1 is a file (but not a symbolic link)
  elif [[ -f "$1" ]]; then
    vf "$1"
  fi
}

# this alias to create a directory
alias dr="dr"

# this function for dr alias
function dr(){
  mkdir "$@" && cv;
}

# this alias to remove a directory
alias rd="rd"

# this function for rd alias
function rd(){
  rm -r "$@" && cv;
}

# this line to have destination location for copy / cut
alias dt="dt"

# this function for dst alias
function dt(){
  dest="$PWD" && c && echo -e && echo "d e s t   s a v e d" | figlet -t -c && sleep 0.6 && cv;
}

# this alias to open a directory
# and make it as destination
alias opd="opd"

# this function for opd alias
function opd(){
  op "$1" && dt && nd;
}

# this alias to create a directory
# and then directly enter to it
alias opdr="opdr"

# this function for opdr alias
function opdr(){
  dr "$*" && op "$*";
}

# this alias to go back from a directory
alias b="b"

# this function for b alias
function b(){
  if [[ $# -eq 0 ]]; then
    cd .. && cv
  else
    for ((i=1; i<=$1;i++)); do
      cd .. && cv
    done
  fi
}

# this alias to go to the previous directory
alias nd="nd"

# this function for nd alias
function nd(){
  cd - &>/dev/null;
  cv;
}

#######################################################################

### Sudo Aliases

# this alias to give sudo
# access before command execution
alias allow_sudo="allow_sudo"

# this function for allow_sudo alias
# HACK : 05-12-2024 15:28
# check if sudo requires a password
# then show the password prompt,
# otherwise just execute the next command
function allow_sudo(){
  sudo -n true &>/dev/null
  if [ $? -eq 1 ]; then
    sudo echo && return 0 || return 1
  else
    return 0
  fi
}

# this alias to simulate the sudo behaviour
alias hndo="hndo"

# this function for hndo alias
function hndo(){
  local attempts=3
  local attempts_num=$(echo $attempts)
  local expected_hashed_password="5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8"
  # this is "password" hashed
  # use this command : echo -n password | sha256sum | awk '{print $1}'

  c && br 2

  while [ $attempts -gt 0 ]; do
    echo -ne "Your Password, Sir : "
    read -s password

    # Hash the entered password
    hashed_input=$(echo -n "$password" | sha256sum | awk '{print $1}')

    if [ "$hashed_input" = "$expected_hashed_password" ]; then
      c && br
      eval "$@"
      return
    else
      attempts=$((attempts - 1))
      br
      echo -n "Wrong, Try Again"
      br
      if [ $attempts -gt 0 ]; then
        continue
      else
        echo "hndo: $attempts_num incorrect password attempts"
        return 1
      fi
    fi
  done
}

# this alias to switch to root
alias ad="ad"

# this function for ad alias
function ad(){
  c && echo -e && echo -e && sudo su && cv;
}

#######################################################################

### Git Alias

# this alias to create a new branch and switch to it
alias gbr="gbr"

# this function for gbr alias
function gbr(){
  local is_a_git_repo=$(git rev-parse --is-inside-work-tree 2>/dev/null)

  if [[ "$is_a_git_repo" == "true" ]]; then
    if [[ $# -eq 1 ]]; then
      git checkout -b "$1";
    elif [[ $# -eq 0 ]]; then
      git branch -a;
    else
      echo "${BOLD} ■■▶ Usage : gbr new_branch" && br;
    fi
  else
    echo "${BOLD} ■■▶ This won't work, you are not in a git repo !" && br;
  fi
}

#######################################################################

### Services Aliases

# this alias to start services
alias svc_on="allow_sudo && svc_on"

# this function for svc_on alias
function svc_on(){
  sudo systemctl start "$1";
}

# this alias to stop systemctl based services
alias svc_off="allow_sudo && svc_off"

# this function for svc_off alias
function svc_off(){
  sudo systemctl stop "$1";
}

# this alias to restart a service
alias svc_rst="svc_rst"

# this function for svc_rst alias
function svc_rst(){
  sudo systemctl restart "$1";
}

# this alias to view systemctl
# based services status
alias svc_stat="allow_sudo && svc_stat"

# this function for svc_stat alias
function svc_stat(){
  sudo systemctl status "$1";
}

# this alias to show if a service if on or off
alias svc_show_stat="allow_sudo && svc_show_stat"

# this function for svc_show_stat alias
function svc_show_stat(){
  br;

  local service_name="$1";
  local check_command="$2";

  if [[ "$check_command" == *"Active: active"* ]]; then
    echo "${BOLD}$service_name Active [${GREEN}✓${WHITE}]";
  elif [[ "$check_command" =~ ^[0-9]+$ ]]; then
    echo "${BOLD}$service_name Active [${GREEN}✓${WHITE}]";
  else
    echo "${BOLD}$service_name Off [${RED}x${WHITE}]";
  fi

  br;
}

# this alias to view the ssh server status
alias sth="sth"

# this function for sth alias
function sth(){
  c && br;
  if [[ $(pgrep sshd) ]]; then
    c && br;
    echo "${BOLD}Ssh Server Active [${GREEN}✓${WHITE}]"
    br;
    local is_wsl=$(grep -qi microsoft /proc/version && echo true || echo false)

    if $is_wsl; then
      local wifi_iface="wifi0"
    else
      # at least it is on kali linux
      local wifi_iface="wlan0"
    fi

    local wifi_ip=$(ifconfig $wifi_iface | grep inet | awk '{print $2}' | grep -v ":");
    # echo " Connect Via  ==>  ssh $USER@$ip";
    # check_ngrok="cmd.exe /c 'tasklist | findstr /I "ngrok"'"
    echo "Ssh Connection via $wifi_iface Interface";
    echo "${BOLD}${WHITE}==> ssh $USER@$wifi_ip";
  else
    echo "${BOLD}Ssh Server Off [${RED}x${WHITE}]"
  fi
}

# this alias to enable the ssh server
alias sshon="allow_sudo && sshon"

# this function for sshon alias
function sshon(){
  local is_wsl=$(grep -qi microsoft /proc/version && echo true || echo false)

  if $is_wsl; then
    sudo /etc/init.d/ssh start &>/dev/null;
  else
    svc_on ssh;
  fi
  sth;
}

# this alias to kill the ssh server process
alias sshoff="allow_sudo && sshoff"

# this function for sshoff alias
function sshoff(){
  # sudo /etc/init.d/ssh stop;
  if [[ $(pgrep sshd) ]]; then
    sudo kill $(pgrep sshd);
  fi
  sth;
}

# this function to view the current apache2
# service, its status
function stap(){
  c && br;
  if [[ $(pgrep apache2) ]]; then
    echo "${BOLD}Apache Server Active [${GREEN}✓${WHITE}]"
    br;

    local eth_iface="eth0"
    local is_wsl=$(grep -qi microsoft /proc/version && echo true || echo false)

    if $is_wsl; then
      local wifi_iface="wifi0"
    else
      # at least it is on kali linux
      local wifi_iface="wlan0"
    fi
    
    local loopback_iface="lo"
    local wlan_ip=$(ifconfig $wifi_iface | grep "inet " | awk '{print $2}');
    local loopback_ip=$(ifconfig $loopback_iface | grep "inet " | awk '{print $2}');

    echo "$wifi_iface Interface Connection (Public)  : ${BRIGHT_BLUE}http://$wlan_ip${WHITE}";
    echo "$loopback_iface    Interface Connection (Private) : ${BRIGHT_BLUE}http://$loopback_ip ${WHITE}";
    br;
  else
    echo "${BOLD}Apache Server Off [${RED}x${WHITE}]"
    br
  fi
}

# this alias to start the apache2 service
alias apon="allow_sudo && apon"

# this function for apch alias
function apon(){
  cd /var/www/html;
  c && br;
  echo "${BOLD}[${GREEN}+${WHITE}]${WHITE} Starting Apache Server ..."; br;
  sudo service apache2 start &>/dev/null;
  stap;
}

# this alias to stop the apache2 service
alias apoff="allow_sudo && apoff"

# this function for apch alias
function apoff(){
  sudo service apache2 stop;
  stap;
}

# this alias to open the
# Apache2 server directory
alias apd="apd"

# this function for apd alias
function apd(){
  op /var/www/html
}

# this alias to start the sql service
alias sqlon="allow_sudo && sqlon"

# this function for sqlon alias
function sqlon(){
  sudo service mariadb start;
  sqls;
}

# this alias to stop the sql service
alias sqloff="allow_sudo && sqloff"

# this function for sqloff alias
function sqloff(){
  sudo service mariadb stop;
  sqls;
}

# this alias to view the sql service
alias sqls="allow_sudo && sqls"

# this function for sqloff alias
function sqls(){
  c && br;
  if [[ $(pgrep mariadb) ]]; then
    echo "${BOLD}MySQL Server Active [${GREEN}✓${WHITE}]"
  else
    echo "${BOLD}MySQL Server Down [${RED}x${WHITE}]"
  fi
}

# this alias to start the postgresql service
alias psqlon="allow_sudo && psqlon"

# this function for sqlon alias
function psqlon(){
  if [[ $(pgrep postgres) ]]; then
    sudo -u postgres psql;
  else
    c && br;
    echo "${BOLD}${WHITE}[${GREEN}+${WHITE}] Starting ${WHITE}PostgreSQL Server ...";
    sudo service postgresql start &>/dev/null;
    c && br;
    echo "${BOLD}PostgreSQL Server Active [${GREEN}✓${WHITE}]";
    br;

    function check_postgres_shell(){
      echo -ne "${BOLD}${WHITE}Access PostgreSQL${GREEN} Shell${WHITE} ? (y/n) ";
      read postgres_shell
      if [ "$postgres_shell" = "y" ]; then
        clear;
        sudo su - postgres;
      elif [ "$postgres_shell" = "n" ];then
        return 1
      else
        check_postgres_shell
      fi
    }
    check_postgres_shell
  fi
  return 0
}

# this alias to stop the postgresql service
alias psqloff="allow_sudo && psqloff"

# this function for sqloff alias
function psqloff(){
  c && br;
  echo "${BOLD}${WHITE}[${RED}x${WHITE}] Stopping ${WHITE}PostgreSQL Server ...";
  sudo service postgresql stop &>/dev/null;
  psqls;
}

# this alias to view the postgresql service
alias psqls="allow_sudo && psqls"

# this function for psqls alias
function psqls(){
  c && br;

  if [[ $(pgrep postgres) ]]; then
    echo "${BOLD}PostgreSQL Server Active [${GREEN}✓${WHITE}]";
  else
    echo "${BOLD}PostgreSQL Server Off [${RED}x${WHITE}]";
  fi

  br;
}

# this alias to start the web servers
alias webon="allow_sudo && webon"

# this function for webon alias
function webon(){
  c && br;
  echo "${BOLD}${WHITE} Starting Web Servers"; br;

  # Apache Server
  echo -ne "${BOLD}${WHITE} ==> Starting ${GREEN}Apache ${WHITE}Server ..."
  sudo service apache2 start &>/dev/null;
  echo -e "[${GREEN}✓${WHITE}]";

  # MySQL Server
  echo -ne "${BOLD} ==> Starting ${GREEN}MySQL ${WHITE} Server ..."
  sudo service mariadb start &>/dev/null;
  echo -e "[${GREEN}✓${WHITE}]";

  # Postfix Server
  echo -ne "${BOLD} ==> Starting ${GREEN}Mail ${WHITE}  Server ..."
  sudo service postfix start &>/dev/null;
  echo -e "[${GREEN}✓${WHITE}]";

  # Status
  br;
  local eth_iface="eth0"
  local is_wsl=$(grep -qi microsoft /proc/version && echo true || echo false)

  if $is_wsl; then
    local wifi_iface="wifi0"
  else
    # at least it is on kali linux
    local wifi_iface="wlan0"
  fi

  local loopback_iface="lo"
  local wlan_ip=$(ifconfig $wifi_iface | grep "inet " | awk '{print $2}');
  local loopback_ip=$(ifconfig $loopback_iface | grep "inet " | awk '{print $2}');

  echo "${BOLD} Access the Server"; br;
  echo " ==> WAN : ${BRIGHT_BLUE}http://$wlan_ip${WHITE}";
  echo " ==> LAN : ${BRIGHT_BLUE}http://$loopback_ip ${WHITE}";
  br;
}

# this alias to stop the web servers
alias weboff="allow_sudo && weboff"

# this function for weboff alias
function weboff(){
  c && br;
  echo "${BOLD}${WHITE} Stopping Web Servers"; br;

  # Apache Server
  echo -ne "${BOLD}${WHITE} ==> Stopping ${RED}Apache ${WHITE}Server ..."
  sudo service apache2 stop &>/dev/null;
  echo -e "[${RED}x${WHITE}]";

  # MySQL Server
  echo -ne "${BOLD} ==> Stopping ${RED}MySQL ${WHITE} Server ..."
  sudo service mariadb stop &>/dev/null;
  echo -e "[${RED}x${WHITE}]";

  # Postfix Server
  echo -ne "${BOLD} ==> Stopping ${RED}Mail ${WHITE}  Server ..."
  sudo service postfix stop &>/dev/null;
  echo -e "[${RED}x${WHITE}]";

  # Status
  br;
}

# this alias to view the web servers status
alias webs="allow_sudo && webs"

# this function for webs alias
function webs(){
  c && br;
  echo "${BOLD} Web Servers Status"; br;

  function check_web(){
    local server_name="$1";
    local app_service="$2";
    local color;
    local sign;

    if sudo service $app_service status &>/dev/null; then
      color="${GREEN}";
      sign="✓";
    else
      color="${RED}";
      sign="x";
    fi

    echo "${BOLD} ==> $server_name Server $color$switch${WHITE}... [$color$sign${WHITE}]";
  }

  # Check apache server
  check_web "Apache" apache2
  check_web "MySQL " mariadb
  check_web "Mail  " postfix

  if sudo service apache2 status &>/dev/null; then
    br;
    local eth_iface="eth0"
    local is_wsl=$(grep -qi microsoft /proc/version && echo true || echo false)

    if $is_wsl; then
      local wifi_iface="wifi0"
    else
      # at least it is on kali linux
      local wifi_iface="wlan0"
    fi

    local loopback_iface="lo"
    local wlan_ip=$(ifconfig $wifi_iface | grep "inet " | awk '{print $2}');
    local loopback_ip=$(ifconfig $loopback_iface | grep "inet " | awk '{print $2}');

    echo "${BOLD} Access the Server"; br;
    echo " ==> WAN : ${BRIGHT_BLUE}http://$wlan_ip${WHITE}";
    echo " ==> LAN : ${BRIGHT_BLUE}http://$loopback_ip ${WHITE}";
    br;
  fi
}

# this alias to start the sql cli
alias rdb="allow_sudo && rdb"

# this function for rdb alias
function rdb(){
  if ! pgrep mariadb > /dev/null; then
    sudo service mariadb start &>/dev/null
  fi
  c && br
  local user=${1:-root}
  echo "${BOLD}MySQL Server Active [${GREEN}✓${WHITE}]"
  echo "${BOLD}User : $user"
  local is_root='[[ "$user" == "root" ]]';
  local flag=$(eval "$is_root" && echo "" || echo "-p");
  sudo mysql -u $user $flag;
  br
  function check_mysql_server(){
    echo -ne "${BOLD}${WHITE}[${GREEN}?${WHITE}]${WHITE} ${GREEN}Stop ${WHITE}MySQL Server ? (y/n) ";
    read server
    if [ "$server" = "y" ]; then
      # echo -ne " ${WHITE}[${GREEN}+${WHITE}]${WHITE} Stopping ${GREEN}MySQL ${WHITE}Server  ";
      echo "${BOLD}${WHITE}[${GREEN}+${WHITE}]${WHITE} Stopping MySQL Server ... "
      sudo service mariadb stop &>/dev/null
      echo "${BOLD}${WHITE}[${GREEN}+${WHITE}]${WHITE} MySQL Server Stopped  ... ${GREEN}✓"
    elif [ "$server" = "n" ];then
      echo "${BOLD}${WHITE}[${GREEN}+${WHITE}]${WHITE} Keeping ${GREEN}MySQL ${WHITE}Server ${GREEN}On";
    else
      check_mysql_server
    fi
  }
  check_mysql_server
}

# this alias to start the sql cli
alias rdbp="rdbp"

# this function for rdbp alias
function rdbp(){
  clear && br 2 && sudo clear;
  sudo systemctl start psql;
  sudo mysql -u root;
  sudo systemctl stop psql;
}

# this alias to check sendmail process
alias mails="allow_sudo && mails"

# this function for mails alias
function mails(){
  c && br;
  if sudo service postfix status &>/dev/null; then
    echo "${BOLD}Mail Server Active [${GREEN}✓${WHITE}]"
  else
    echo "${BOLD}Mail Server Down [${RED}x${WHITE}]"
  fi
}

# this alias to start sendmail service
alias mailon="allow_sudo && mailon"

# this function for mailon alias
function mailon(){
  sudo service postfix start
  mails
}

# this alias to stop sendmail service
alias mailoff="allow_sudo && mailoff"

# this function for mailon alias
function mailoff(){
  sudo service postfix stop
  mails
}

# this alias to check snmp service
alias snmps="snmps"

# this function for snmps alias
function snmps(){
  local name="SNMP Server";
  local cmd="$(pgrep snmpd)";
  svc_show_stat $name $cmd;
}

# this function to start snmpd service
alias snmpon="snmpon"

# this function for snmpon alias
function snmpon(){
  svc_on snmpd;
  snmps;
}

# this alias to stop the snmp service
alias snmpoff="snmpoff"

# this function for snmpoff alias
function snmpoff(){
  svc_off snmpd;
  snmps;
}

#######################################################################

### File Aliases

# this alias to create a file
alias tf="tf"

# this function for tf alias
function tf(){
  touch "$@" && all "$@" && cv;
}

# this alias to delete file
alias dlf="dlf"

# this function for dlf alias
function dlf(){
  rm "$@" && cv;
}

# this alias to copy a file then display it
alias cpf="cpf"

# this function for cpf alias
function cpf(){
  if [[ $# -eq 2 ]]; then
    if [[ -d "$1" ]]; then #here to check if the first argument is a directory
      cp -r "$1" "$2" && op "$2" && all "$1";
    else
      cp "$1" "$2" && op "$2" && all "$1";
    fi
  elif [[ $# -eq 1 ]]; then
    if [[ -d "$1" ]]; then #here to check if the first argument is a directory
      cp -r "$1" "$dest" && op "$dest" && all "$1";
    else
      cp "$@" "$dest" && op "$dest" && all "$@";
    fi
  fi
}

# this alias to copy the content of a file
alias cnf="cnf"

# this function for cnf alias
function cnf(){
  cat "$1" > "$2" && dlf "$1" && all "$2";
}

# this alias to copy a file then display it
alias mvf="mvf"

# this function for cpf alias
function mvf(){
  if [[ $# -eq 2 ]]; then
    mv "$1" "$2" && op "$2";
  elif [[ $# -eq 1 ]]; then
    mv $@ $dest && op $dest;
    # if there is only one argument,
    # it will move the file / directory
    # to the the variable
    # dest defined in dt alias
  fi
}

# this alias to force delete
alias rdf="allow_sudo && rdf"

# this function for rdf alias
function rdf(){
  sudo rm -rfv "$@";
  cv;
}

# this alias to count the number of file/directory
# inside a directory
alias dc="dc"

#this function for dc alias
function dc(){
  if [[ $# -eq 0 ]]; then
    clear;
    br;
    case "$(ls -1 | wc -l)" in
      0)
        br;
        echo "There is nothing inside $(basename $PWD)";
        br;;
      *)
        case "$(ls -1 | wc -l)" in
          1)it="item";;
          *)it="items";;
        esac
        echo "   $(basename $PWD) folder has $(ls -1 | wc -l) $it : ";
        br;
        if [[ $(ls -1 | wc -l) -gt 50 ]]; then
          br;
        else
          ls
        fi
        br;
    esac
  elif [[ $# -eq 1 ]]; then
    clear;
    br;
    case "$(ls -1 $1 | wc -l)" in
      0)
        br;
        echo "There is nothing inside $(basename $1)";
        br;
        sleep 1;
        cv;
        br;;
      *)
        case "$(ls -1 $1 | wc -l)" in
          1)it="item";;
          *)it="items";;
        esac
        echo "   $(basename $1) folder has $(ls -1 $1 | wc -l) $it : ";
        br;
        if [[ $(ls -1 "$1" | wc -l) -gt 50 ]]; then
          br;
        else
          ls "$1";
        fi
        br;
        sleep 1;
        cv;
    esac
  fi
}

# this alias to know the file type
alias tp="tp"

# this function for tp alias
function tp(){
  type=$(ls -ld "$1" | cut -c1)
  case $type in
    -) echo "File" ;;
    d) echo "Directory" ;;
    b) echo "Block" ;;
    l) echo "Sym-Link" ;;
    c) echo "Character" ;;
    *) echo "Other" ;;
  esac
}

#######################################################################

### Explorer Alias

# this alias to open the current
# directory inside windows explorer
# or bu the default explorer on Linux
alias exop="exop"

# this function for exop alias
function exop() {
  [ $# -eq 1 ] && cd "$1"

  # check WSL
  local is_wsl=$(
    grep -qi microsoft /proc/version && echo true || echo false
  )

  if $is_wsl; then
    explorer.exe .
  else
    xdg-open .
  fi
  cv
}

#######################################################################

### Custom command not found

# Printing command not found when it is the case
command_not_found_handler() {
  local command=$1
  local command_found=0

  # Check if the command is found in the .zshrc file
  if grep -q -E "^alias $command=" "$HOME/.zshrc" ; then
    command_found=1
  fi

  if [[ $command_found -eq 0 ]]; then
    echo " ${BOLD}${WHITE}[${RED}x${WHITE}]${WHITE} Command Not Found"
  fi
}

#######################################################################

### $SHELLrc Aliases

# this alias to edit $SHELLrc
alias ct="nvim ~/.zshrc"

# this alias to reload the zshrc file
alias rld="rld"

# this function for rld alias
function rld(){
  c;

  # local variables
  local shellrc=.$(basename $SHELL)rc;
  local is_wsl=$(grep -qi microsoft /proc/version && echo true || echo false)
  local platform=$($is_wsl && echo "wsl" || echo "linux")
  local backup_dir=$HOME/Files/custom_shellrc/$platform;
  local backup_file=zshrc[$USER].sh;
  local saved_message="$shellrc backed up"

  # source the config file and save it
  source ~/$shellrc;
  cat ~/$shellrc > $backup_dir/$backup_file;

  # saved message display
  c && br;
  echo "${BOLD}${WHITE}$saved_message";
  br && sleep 0.5;
  op $backup_dir;
}

#######################################################################

### Neovim Aliases

# this alias to open the current directory inside neovim
alias nvm="nvm"

# this function for nvm aliases
# if we have one argument then nvim will be launched with it,
# otherwise open the current directory if there is no argument
function nvm(){
  nvim "${1:-.}";
}

# this alias to call neovim in a cooler way
alias hnvim="nvim"

# this alias to open nvim as root
alias nvmr="allow_sudo && nvmr"

# this function for nvmr alias
function nvmr(){
  sudo nvim "${1:-.}";
}

# this alias to edit a file
alias ed="ed"

# this function for ed alias
function ed(){
  # nvim -c "startinsert" "$1" && cv;
  nvim "$1" && cv;
}

#######################################################################

### Kali Linux Paths

# Function to add directories to $PATH
# if they're not already included
# to avoid redondancy when reloading zshrc
function add_to_path() {
  local DIR="$1"
  if [[ ":$PATH:" != *":$DIR:"* ]]; then
    export PATH="$DIR:$PATH"
  fi
}

# Define paths
CUPP_PATH=/usr/share/cupp
GO_PATH=/usr/local/go/bin
HOME_PATH=$HOME/bin
SCP_PATH=/usr/bin/scp
SIPP_PATH=/home/h471x/Desktop/sipp
ANDROID_HOME=$HOME/Android/Sdk
ANDROID_TOOLS=$ANDROID_HOME/cmdline-tools/latest/bin
ANDROID_PLATFORM=$ANDROID_HOME/platform-tools
ANDROI_PATH=$ANDROID_TOOLS:$ANDROID_PLATFORM

# Add the paths using the function
add_to_path $CUPP_PATH
add_to_path $HOME_PATH
add_to_path $GO_PATH
add_to_path $SCP_PATH
add_to_path $SIPP_PATH
add_to_path $ANDROID_PATH

# here to hide the java options
unset _JAVA_OPTIONS

# this alias to copy the current
# directory path in linux format
alias path="path"

# this function for path alias
function path {
  echo $PWD | xclip -selection clipboard
  echo "Path Copied."
}

#######################################################################

### Kali Linux Shortcuts Aliases

# this alias to view the usb device connected here
alias usb="op /media/h471x"

# this alias to open the shared folder
alias sf="op /media/sf_ENI_2023"

# this alias to view the pc state
alias pc="c && br 2 && neofetch --source ~/.config/neofetch/htx2.txt"

# this alias to go to home directory
alias hm="cd && cv"

# this alias to access / directory
alias rt="cd / && cv"

# this alias to enter the NTSOA directory
alias hn="op ~/NTSOA"

# this alias to go to the download folder
alias dwl="op /home/h471x/Downloads"

# this alias to open the HACK directory
alias hack="op /home/h471x/NTSOA/hack"

# this alias to open the ENI CYBERSECURITY directory
alias cs="op /home/h471x/NTSOA/ENI\ CYBERSECURITY"

# this alias to enter the devops course
alias dvps="op /home/h471x/NTSOA/COURSE/DEVOPS/NOTES "

# this alias to view the aws informations
alias awsd="op /home/h471x/NTSOA/COURSE/DEVOPS/AWS "

# this alias to go to the to desktop
alias dtp="op /home/h471x/Desktop"

# this alias to go to the to dev
alias dev="op /home/h471x/NTSOA/dev"

# this alias to open the windows dev shared folder
alias wdev="op /media/sf_DEV"

# this alias to open the text notes
alias nt="op /home/h471x/NTSOA/notes"

# this alias to open HTX USB
alias htx="op /media/h471x/HTX\ USB"

# this alias to open the shareed folder
alias kali="op /media/sf_KALI_LINUX"

# this alias to open the books shared folder
alias books="op /media/sf_BOOKS"

# this alias to open ENI shared folder
alias eni="op /media/sf_0_ENI/ENI\ 2024"

# this alias to view the pictures folder
alias pct="pct"

# this function for pct alias
function pct(){
  op /home/$USER/Pictures;
}

# this alias to directly go to JPG version of the time schedule
alias ej="c && op /home/h471x/NTSOA/EDT\ ENI/JPG/L2\ 2024"

# this alias to convert pdf to jpg for EDT
alias ei="ei"

# this function for ei alias
function ei(){
  # useful variables
  local input_pdf="$1"
  local output_image="$(basename "$input_pdf" .pdf).jpg";
  local kali_edt_path=/home/h471x/NTSOA/EDT\ ENI/JPG/L2\ 2024;
  local windows_edt_path=/media/sf_0_ENI/ENI\ 2024/0\ EDT/L2\ 2024

  # convert pdf to jpg using imagemagick convert
  convert -density 500 "$input_pdf" "$output_image";

  # full access to the files
  all "$input_pdf";
  all "$output_image";

  # moving to the right directories
  cp "$output_image" $windows_edt_path;
  mv "$output_image" $kali_edt_path;

  # Success message
  c && br 2;
  echo "${GREEN}${BOLD} ==> SUCCESS ${WHITE}"
  br;
  echo "${BOLD} $input_pdf -> $output_image ${RESET}";
  br;
  sleep 3;

  # open the edt list
  op $windows_edt_path;
}

# this alias to edit the time schedule
alias edt="edt"

# this function for edt alias
function edt(){
  cd /home/h471x/NTSOA/'EDT ENI'/ODS;
  op "EDT ENI L2 2024.ods"
  op /home/h471x/NTSOA/'EDT ENI'/PDF;
}

# this alias to view the time schedule
alias edt="edtv"

# this function for edt alias
function edtv(){
  op /home/h471x/NTSOA/'EDT ENI';
}

#######################################################################

### Host Aliases

#this alias to open hosts files
alias hosts="nvmr /etc/hosts"

# this alias to add new host
alias new_host="allow_sudo && new_host"

# this function for new_host alias
function new_host {
  local host
  local redirection
  local description

  # Get the host
  echo -ne " Source Host : "
  read host

  # Get the redirection
  echo -ne " Redirection : "
  read redirection

  # Get the description
  echo -ne " Description : "
  read description

  # Remove any ANSI escape codes from inputs
  host=$(echo "$host" | sed 's/\x1b\[[0-9;]*m//g')
  redirection=$(echo "$redirection" | sed 's/\x1b\[[0-9;]*m//g')
  description=$(echo "$description" | sed 's/\x1b\[[0-9;]*m//g')

  sudo echo -e "\n# $description\n$host $redirection" \
    | sudo tee -a /etc/hosts > /dev/null
}

# this alias to add host
alias add_host="allow_sudo && add_host"

# Function to add hosts interactively
function add_host {
  if [[ "$#" -eq 0 ]]; then
    echo "Please specify the entry point to add!"
    return 0
  fi

  local host="$1"
  local ip=$(awk -v h="$host" '$2 == h {print $1}' /etc/hosts)
  local redirection

  # display informations
  echo " Source Host : $ip"
  echo " Redirection : $host"

  echo -ne " Additional  : "
  read redirection

  # Add a new entry
  sudo sed -i "/$host/s/$/ $redirection/" /etc/hosts
}

# complete add_host for host adding
compctl -K _host_completion add_host

# this alias to edit hosts IP
alias edit_host="allow_sudo && edit_host"

# this function for edit_host alias
function edit_host {
  local host="$1"
  local ip=$(awk -v h="$host" '$2 == h {print $1}' /etc/hosts)
  local new_ip

  echo " Redirection  : $host"
  echo " Source IP    : $ip"

  # Get the new IP
  echo -ne " Enter New IP : "
  read new_ip

  # Replace the old IP with the new IP
  sudo sed -i "s/^$ip/$new_ip/" /etc/hosts
}

# this alias to change hosts
alias change_host="allow_sudo && change_host"

# this function for change_host alias
function change_host {
  local host="$1"
  local ip=$(awk -v h="$host" '$2 == h {print $1}' /etc/hosts)
  local new_ip

  echo " Source IP    : $ip"
  echo " Redirection  : $host"

  # Get the new IP
  echo -ne " Change Host  : "
  read new_host

  # Replace the old IP with the new IP
  sudo sed -i "s/$host/$new_host/g" /etc/hosts
}

# complete the hosts functions
# with /etc/hosts entries
_host_completion() {
  reply=($(awk '!/^#/ && NF {print $2}' /etc/hosts))
}

# autocomplete edit_host & change_host
compctl -K _host_completion edit_host
compctl -K _host_completion change_host

#######################################################################

### Kali Linux Network Aliases

# this function to switch from ethernet to wireless connection
function wf(){
  c && br 2;
  sudo clear;
  br 2;
  if [ -d /sys/class/net/wlan0 ]; then
    downnet eth0 && upnet wlan0;
    echo "w i r e l e s s" | figlet -t -c;
    tlk "wifi on";
    br && sleep 1 && cv;
  else
    echo "Can't switch to wireless, wlan0 not found";
    br;
  fi
}

# this function to bring a connection interface up 
function upnet(){
  sudo ifconfig "$1" up;
}

# this function to bring a connection interface down 
function downnet(){
  sudo ifconfig "$1" down;
}

# # this alias to show the network configuration
# alias ipsh="ipsh"
#
# # this function for ntsh alias
# function ipsh(){
#   c && br;
#   echo "  Available IP Adresses : ";
#   br;
#   # ifconfig wlan0;
#   # br;
#   local eth_ip=$(ifconfig eth0 | grep "inet " | awk '{print $2}');
#
#   # Add a conditon to make it view
#   # IP from interface passed as argument
#   if [[ $# -eq 1 ]]; then
#     local iface_ip=$(ifconfig "$1" | grep "inet " | awk '{print $2}');
#     echo " $1 ==> $iface_ip";
#   else
#     if [ -d /sys/class/net/wlan0 ]; then
#       local wlan_ip=$(ifconfig wlan0 | grep "inet " | awk '{print $2}');
#       echo " wlan0 ==> $wlan_ip";
#       echo " eth0  ==> $eth_ip" && br;
#     else
#       echo " eth0 IP ==> $eth_ip" && br;
#     fi
#   fi
#
#   # ifconfig | awk -F '[ :]+' '/^[a-z]/ {interface=$1} /inet / {print interface " ==> " $3}'
# }

# this alias to show IPV4 IP addresses
alias show_ip="show_ip"

# this fucntion for show_ip alias
function show_ip {
  # Declare an associative array (Zsh specific syntax)
  typeset -A iface_ip_map

  # Logical parts of the AWK command
  match_interfaces='/^[a-z]/ { iface=$1; sub(":", "", iface) }'
  match_ip='/inet / && $2 != "127.0.0.1" { print iface, $2 }'

  # Combine the parts into the full AWK command
  awk_cmd="$match_interfaces $match_ip"

  # Extract interface names and IPs into a variable
  interfaces=$(ifconfig | awk "$awk_cmd")

  # Loop through the extracted data and populate the associative array
  while read iface ip; do
    iface_ip_map["$iface"]="$ip"
  done <<< "$interfaces"

  # Output the associative array in a key-value format
  for iface in ${(k)iface_ip_map}; do
    echo $iface:${iface_ip_map[$iface]}
  done
}

# this alias to show the network configuration
alias ipsh="ipsh"

# this function for ntsh alias
function ipsh {
  # Example of predefined commands (modify as needed)
  c && br  # Your predefined commands
  echo " Available IP Addresses: "
  br  # Your predefined command

  # Capture the output of show_ip
  map_output=$(show_ip)

  # # Debugging: print the raw output of show_ip
  # echo "Raw map_output:"
  # echo "$map_output"

  # Find the length of the longest interface name (after stripping quotes and colons)
  longest_iface_length=$(echo "$map_output" | sed -E 's/"([^"]+)":.*/\1/' | awk '{ print length }' | sort -n | tail -n 1)

  # # Debugging: print the longest interface length
  # echo "The longest interface length is: $longest_iface_length"

  # Loop through each line of the map_output, stripping quotes from iface and aligning
  while IFS=: read -r iface ip; do
    iface=$(echo "$iface" | tr -d '"')  # Remove any quotes from iface
    iface=$(echo "$iface" | tr -d ' ')  # Remove any extra spaces from iface

    # # Debugging: print the current interface and IP
    # echo "Processing iface: $iface, ip: $ip"

    # Calculate how many spaces need to be added to align the '==>'
    spaces_to_add=$((longest_iface_length - ${#iface}))

    # # Debugging: print the number of spaces to add
    # echo "Spaces to add for $iface: $spaces_to_add"

    # Only add spaces if spaces_to_add is greater than 0
    if (( spaces_to_add > 0 )); then
      padded_iface="$iface$(printf ' %.0s' {1..$spaces_to_add})"
    else
      padded_iface="$iface"
    fi

    # Print the iface and ip, ensuring alignment of '==>'
    echo "$padded_iface ==> $ip"
  done <<< "$map_output"

  br
}

# this alias to list the local IP adresses
alias ipls="ipls"

# this function for ipls alias
function ipls(){
  c && br;
  echo "   Local Devices IP Adresses : ";
  br;
  arp -e;
  br;
}

# this alias to show the network configuration
alias ntsh="ntsh"

# this function for ntsh alias
function ntsh(){
  c && br;

  if [ -d /sys/class/net/wlan0 ]; then
    echo "      Wireless Network informations : ";
    if [[ $# -eq 0 ]]; then
      br;
      iwconfig wlan0 | grep "Mode" | awk -F ":" '{print $2}' | grep M | awk '{print "wlan0 Mode ==> " $1}';
      br;
    elif [[ $# -eq 1 ]]; then
      br && iwconfig "$1" && br;
    fi
  else
    echo "No Wireless adapter found" && br;
  fi
}

# this alias to define the type of the wireless adapter
alias wtp="wtp"

# this function for wtp alias
function wtp(){
  if [[ $# -eq 2 ]]; then
    sudo ip link set "$1" down;
    sudo iw "$1" set type "$2";
    sudo ip link set "$1" up;
  else
    c && br 2;
    echo "Invalid Argument" | figlet -t -c;
    br;
  fi
}

# this alias to scan wifi
alias scn="scn"

# this function for scn alias
function scn(){
  c && br 2 && sudo clear;
  wtp wlan0 monitor;
  br 2;
  echo "s c a n n  i n g . . ." | figlet -t -c | lolcat;
  sleep 1;
  sudo airodump-ng wlan0;
  wtp wlan0 managed;
  br;
}

# this function to kill process
function kl(){
  if pgrep -f "$1">/dev/null; then
    sudo kill $(pgrep "$1");
  fi
}

# this alias to switch to monitor mode
alias mntr="mntr"

# this function for mntr alias
function mntr(){
  c && br 2;
  sudo clear;

  if [ -d /sys/class/net/wlan0 ]; then
    c && br 2 && sudo clear;
    kl NetworkManager;
    kl wpa_supplicant;
    kl dhclient;
    sudo airmon-ng start wlan0 && c;
    echo "M o n i t o r" | figlet -t -c;
    sleep 0.5;
    br;
  else
    br 2;
    echo "No wireless adapter";
    br;
  fi
}

# this alias to set the network adapter to monitor mode
# in another way
alias rmon="rmon"

# this function for rmn alias
function rmon(){
  c && br 2 && sudo clear;
  sudo airmon-ng check wlan0;
  c;
  sleep 1;
  sudo airmon-ng check kill wlan0;
  c;
  sleep 1;
  sudo airmon-ng start wlan0;
  c;
  echo "M o n i t o r     M o d e" | figlet -t -c | lolcat;
  sleep 1;
  c && br;
  ntsh;
}

# this alias to switch to managed mode
alias mngd="mngd"

# this function for mngd alias
function mngd(){
  c && br 2 && sudo clear;
  wtp wlan0 managed;
  br 2;
  echo "M a n a g e d     M o d e" | figlet -t -c | lolcat;
  tlk "managed mode";
  sleep 0.5;
  c && br;
  ntsh;
}

# this alias to restart the network manager after a hack
alias rst="allow_sudo && rst"

# this function for rst alias
function rst(){
  c && br 2;
  sudo service NetworkManager restart;
  br 2;
  echo "N e t     R e s e t" | figlet -t -c;
  # tlk "network reset";
  sleep 1;
  sudo service NetworkManager restart;
  upnet eth0;
  #upnet eth1;
  if [ -d /sys/class/net/wlan0 ]; then
    upnet wlan0;
    wtp wlan0 managed;
    sleep 0.5;
  fi
  cv;
}

# this alias to run wifite
alias whk="allow_sudo && whk"

# this function for whk alias
function whk(){
  function hack_wifi(){
    sudo wifite --kill;
    br;

    # this function will ask if the
    # hacking should restart or not
    function check_quit(){
      echo -ne " ${BOLD}${WHITE}[${GREEN}?${WHITE}]${WHITE} ${GREEN}Restart ${WHITE}the wifi hacking ? (y/n) ";
      read wifi
      if [ "$wifi" = "y" ]; then
        whk
      elif [[ "$wifi" = "n" ]]; then
        echo -ne " ${BOLD}${WHITE}[${GREEN}+${WHITE}]${WHITE} Switching to ${GREEN}Managed ${WHITE}Mode  ";
        # downnet eth0
        upnet wlan0;
        wtp wlan0mon managed;
        echo "${GREEN}  ${WHITE}"
        echo -ne " ${BOLD}${WHITE}[${GREEN}+${WHITE}]${WHITE} Restarting Network Manager "
        sudo service NetworkManager restart;
        echo "${GREEN}  ${WHITE}"
      else
        check_quit
      fi
    }
    allow_sudo && check_quit
  }

  if [ -d /sys/class/net/wlan0 || -d /sys/class/net/wlan0mon ]; then
    c && br
    hack_wifi
  else
    br
    echo "  ${BOLD}${WHITE}[${RED}x${WHITE}]${WHITE} No ${RED}Wireless Card ${WHITE}Available"
    br
  fi
}

# this alias to create a Fake Access Point
alias facp="allow_sudo && facp"

# this function for facp alias
function facp(){
  if [ -d /sys/class/net/wlan0 ]; then
    sudo systemctl stop NetworkManager
    sudo systemctl stop wpa_supplicant
    sudo ifconfig wlan0 down
    sudo ifconfig wlan0 up
    sudo airbase-ng --essid "$*" -c 11 wlan0
  else
    echo "No wireless adapter found"
  fi

  function check_quit(){
    echo -ne " ${BOLD}${WHITE}[${GREEN}?${WHITE}]${WHITE} ${GREEN}Restart ${WHITE}the Fake Acces Point ? (y/n) ";
    read wifi
    if [ "$wifi" = "y" ]; then
      whk
    elif [[ "$wifi" = "n" ]]; then
      echo -ne " ${BOLD}${WHITE}[${GREEN}+${WHITE}]${WHITE} Switching to ${GREEN}Managed ${WHITE}Mode  ";
      downnet eth0 && upnet wlan0;
      wtp wlan0 managed;
      echo "${GREEN}  ${WHITE}"
      echo -ne " ${BOLD}${WHITE}[${GREEN}+${WHITE}]${WHITE} Restarting Network Manager "
      sudo service NetworkManager restart;
      echo "${GREEN}  ${WHITE}"
    else
      check_quit
    fi
  }
  check_quit
}

# this alias to deauth wireless connection
alias deauth="deauth"

# this function for deatuh alias
function deauth(){
  if [[ $# -ge 1 ]]; then
    if [ -d /sys/class/net/wlan0 ]; then
      c && br 2 && sudo clear;

      if [[ !$(pgrep NetworkManager) ]]; then
        sudo systemctl start NetworkManager;
        wtp wlan0 managed;
      fi

      kl wpa_supplicant;
      kl dhclient;

      echo "        D e A u t h" | figlet && br;
      echo " ==> Target Wi-Fi : '$*' " && br;
      ssid="$*"
      bssid=$(nmcli -f BSSID,SSID device wifi list | grep "$ssid" | awk '{print $1}')
      # bssid=$(sudo iw dev wlan0 scan | grep -B 8 "SSID: $ssid" | awk -F "(" '/^BSS/{print $1}' | tr '[:lower:]' '[:upper:]' | sed 's/BSS //');
      # here we use the iw dev wlan0 scan to show the wireless networks without using nmcli
      # the grep -B 8 means it will match the eight's line before the found on the pattern
      # use grep -A to match lines after the matched one
      # awk -F "" will set the delimiter between matches and then it will print the first side of the matching pattern 
      # tr will then convert all the letter to uppercase
      # the sed 's/BSS //' will replace BSS to nothing
      # what can I say, today 11/11/2023 I'm becoming more and more good at pattern matching
      if [ -n "$bssid" ]; then
        # if [[ -n $(sudo airmon-ng check wlan0) ]]; then
        #   sudo airmon-ng check kill wlan0;
        # fi
        sudo aireplay-ng -0 0 -a "$bssid" wlan0 --ignore-negative-one;
      else
        echo "SSID '$ssid' not found";
        br;
      fi
    else
      echo "No wireless adapter found";
      br;
    fi
  else
    echo "Please pass the Wi-Fi SSID as the argument";
  fi
}

# this alias to connect to a wifi via CLI
alias wcnt="wcnt"

# this function for wcnt alias
function wcnt(){
  if [[ $# -eq 1 ]]; then
    if [ -d /sys/class/net/wlan0 ]; then
      nmcli device wifi connect "$1";
    else
      echo " No wireless adapter found";
      br;
    fi
  elif [[ $# -eq 2 ]]; then
    if [ -d /sys/class/net/wlan0 ]; then
      nmcli device wifi connect "$1" password "$2";
    else
      echo " No wireless adapter found";
      br;
    fi
  else
    echo "Please pass the Wi-Fi SSID as argument";
  fi
}

# this alias to list all the wifi nearby
alias wls="allow_sudo && wls"

# this function for wls alias
function wls(){
  if [ -d /sys/class/net/wlan0 ]; then
    downnet eth0 && upnet wlan0;
    c && br 2;
    echo " Wi-Fi connections nearby : " && br;
    nmcli device wifi list
    # nmcli -f SSID,BSSID,SECURITY,CHAN,SIGNAL,BARS,RATE,MODE device wifi list
    # nmcli -f SSID,SECURITY,CHAN,SIGNAL,BARS,RATE,MODE device wifi list
    # wait;
    br;
  else
    c && br 2;
    echo "No wireless adapter";
    br;
  fi
}

# this function to check saved wifi network
function wchk(){
  # Get the saved Wi-Fi connections
  nmcli connection show | grep -q "$1" && echo "$1 found" || echo "$1 not found"
  # We have a cool ternary expression here :D
}

# this alias to run airgeddon
alias rhk="allow_sudo && rhk"

# this function for rhk alias
function rhk(){
  sudo airgeddon
}

# this alias to run the cupp command
alias cupp="cupp"

# this function for cupp alias
function cupp(){
  c && br;
  if [[ $# -eq 0 ]]; then
    cupp.py -i;
  elif [[ $# -gt 0 ]]; then
    cupp.py $@;
  fi
}

# this alias to ping a network
alias reach="allow_sudo && reach"

#this function to check if pfsense is reachable
# coded 01/29/2024
function reach(){
  local target_IP="$1"
  local check_message="Checking $target_IP reachability..."
  local check_IP="sudo ping -c 1 -W 5 "
  local reachable="c && br && echo ' $check_message' && eval $check_IP $target_IP &> /dev/null;"
  # the -c 1 means we send one packet to test it
  # the -W 5 means if the ping have 5 seconds to check
  # as always we run it in background in order to
  # not see all the boring logs messages

  if eval $reachable ;then
    #if PfSense is reachable then
    #we execute the next command after
    #this function calling
    # eval "$@"
    echo " $target_IP is reachable"
  else;
    echo " $target_IP is not reachable"
  fi
}

#######################################################################

### Python Aliases

# this alias to launch exegol
alias exegol='sudo -E /home/h471x/.local/bin/exegol'

# exegol auto completion
eval "$(register-python-argcomplete --no-defaults exegol)"

# This function finds all Python virtual
# environments in the current directory and returns them as an array.
function find_envs {
  local envs=()

  # Enable 'nullglob' to prevent errors when using glob patterns (e.g., "$PWD"/*/)
  # In Zsh, if a glob pattern doesn't match any files or directories, an error like
  # "no matches found" is thrown. By setting 'nullglob', unmatched glob patterns
  # will expand to an empty string instead of causing an error. This allows safe iteration
  # through directories even when no matches are found.
  # We'll turn it off later (with 'unsetopt nullglob') to restore the default behavior,
  # ensuring that this change is only temporary within the script.
  setopt nullglob

  for dir in "$PWD"/*/ "$PWD"/.*/; do
    [[ -f "$dir/bin/activate" ]] && envs+=("$dir")
  done
  echo "${envs[@]}"
}

function create_env {
  echo "Creating virtual environment..."
  if command -v uv >/dev/null 2>&1; then
    uv --quiet venv .venv
  else
    python3 -m venv .venv
  fi
  source_env
}

function source_env {
  echo "Activating virtual environment..."
  source "$PWD/.venv/bin/activate"
}

function deactivate_env {
  echo "Deactivating virtual environment..."
  deactivate
}

function delete_env {
  echo "Deleting virtual environment..."
  rm -rf "$PWD/.venv"
}


# this function for python environment management
function pyenv {
  [[ "$1" == "delete" ]] && {
    [[ -n "$VIRTUAL_ENV" ]] && deactivate_env
    delete_env
    return 0
  }

  [[ ! -d "$PWD/.venv" ]] && {
    create_env
    return 0
  }

  [[ -n "$VIRTUAL_ENV" ]] && deactivate_env || {
    source_env
  }
}

#######################################################################

### Kali Linux Programs Aliases

# this alias to run an executable file or a script
alias rn="rn"

# this function for rn alias
function rn(){
  #this will look for the extension of the file
  case "${1##*.}" in
    class)
      java "$1";;
    py)
      if [[ $# -eq 1 ]]; then
        python3 "$1";
        return 0;
        # br;
      elif [[ $# -gt 1 ]]; then
        all "$1";
        c && br;
        python3 "$1" "$@";
        return 0;
        br;
      fi
    ;;
    c || cpp) # update 07/28/2023
      file="$1";
      out="${file%.*}"

      # Condition 1: Check if the file extension is c
      extension='[[ "${file##*.}" == "c" ]]';

      # Condition 2: Check if the file contains math library
      math='grep -E "^#include <math.h>" "$file" >/dev/null';

      # Ternary expressions to determine compiler and flags
      compiler=$(eval "$extension" && echo "gcc" || echo "g++");
      flags=$(eval "$math" && echo "-lm" || echo "");

      # check if an old executable exists
      if [[ -f "$out" ]]; then
        dlf "$out";
      fi

      # Compile the C file
      "$compiler" "$file" -o "$out" $flags;

      # Execute the resulting executable
      all "$out";
      clear && br;
      ./"$out";
      br;;
    html)
      google-chrome "$1" && cv;;
    asm)
      nasm -felf64 "$1"
      ld ${1%.*}.o -o ${1%.*}
      ./${1%.*}
      ;;
    *)
      all "$1" && c && ./"$1";;
esac
}

# this alias to run an executable file or a script
alias rns="allow_sudo && rns"

# this function for rn alias
function rns(){
  #this will look for the extension of the file
  case "${1##*.}" in
    py)
      if [[ $# -eq 1 ]]; then
        # all "$1";
        # c && br;
        python3 "$1";
        return 0;
        # br;
      elif [[ $# -gt 1 ]]; then
        all "$1";
        c && br;
        python3 "$1" "$@";
        return 0;
        br;
      fi
    ;;
    c || cpp) # update 07/28/2023
      file="$1";
      out="${file%.*}"

      # Condition 1: Check if the file extension is c
      extension='[[ "${file##*.}" == "c" ]]';

      # Condition 2: Check if the file contains math library
      math='grep -E "^#include <math.h>" "$file" >/dev/null';

      # Ternary expressions to determine compiler and flags
      compiler=$(eval "$extension" && echo "gcc" || echo "g++");
      flags=$(eval "$math" && echo "-lm" || echo "");

      # check if an old executable exists
      if [[ -f "$out" ]]; then
        dlf "$out";
      fi

      # Compile the C file
      "$compiler" "$file" -o "$out" $flags;

      # Execute the resulting executable
      all "$out";
      clear && br;
      ./"$out";
      br;;
    html)
      google-chrome "$1" && cv;;
    asm)
      nasm -felf64 "$1"
      ld ${1%.*}.o -o ${1%.*}
      ./${1%.*}
      ;;
    *)
      all "$1" && c && sudo ./"$1";;
esac
}

# this alias to make the pc talk
alias tlk="espeak -v en+m3 -s 150" 
# -v en+m3 -s 150" ==> those are optional

# this function for tlk alias
function tlk1(){
  espeak "$1" && cv;
}

# this alias to serve files via the Php server
alias srv="srv"

# this function for srv alia
function srv(){
  php -S 127.0.0.1:50000;
  google-chrome 127.0.0.1:50000/"$1";
}

# alias to view inside a file
alias vf="vf"

# function for vf alias
# update 09/14/2023
function vf() {
  local file="$1"
  local extension="${file##*.}"

  case "$extension" in
    mcd)
      cmd="katyushamcd";;
    *)
      cmd="xdg-open";;
  esac

  "$cmd" "$file" && cv
}

# this alias to view binary file
alias vfb="vfb"

# this function for vfb alias
function vfb(){
  od -t x1 -A n "$1";
}

# this alias to copy files
alias cpf="cpf"

# this function for cpf alias
function cpf(){
  local copy_target=${2:-$dest}
  cp -r "$@" "$copy_target" && op "$copy_target";
}

function cpf2() {
  cp "${@:1:$#-1}" "${@:$#}";
}

# this alias to copy the content of a file
alias cnf="cnf"

# this function for cnf alias
function cnf(){
  cat "$1" > "$2" && dlf "$1" && all "$2";
}

# this alias to locate packages
alias lc="lc"

# this function for lc alias
function lc(){
  locate "$1" | less && cv;
}

# this alias for ngrok
alias ngrok="ngrok"

# this function for ngrok alias
# IMPROVED: 05-30-2024 14:12
function ngrok() {
  # get the ngrok arguments
  local ngrok_args="$@"

  # check for dashes then do not
  # redirect to another terminal
  for arg in "$@"; do
    if [[ "$arg" == *-* ]]; then
      command ngrok "$@"
      return
    fi
  done

  (setsid qterminal -e bash -c "ngrok $ngrok_args" >/dev/null 2>&1 &)
}

# this alias to view the irc sever status
alias irth="irth"

# this function for irth alias
function irth(){
  c && br 2 && sudo clear;
  echo "    irc server status : ";
  br;
  sudo service inspircd status ;
  br;
}

# this alias to start the irc server
alias ircon="ircon"

# this function for ircon alias
function ircon(){
  clear && br 2 && sudo clear;
  sudo service inspircd start;
  irth;
}

# this alias to restart the irc server
alias ircrst="ircrst"

# this function for ircrst alias
function ircrst(){
  clear && br 2 && sudo clear;
  sudo service inspircd restart;
  irth;
}

# this alias to stop the irc server
alias ircoff="ircoff"

# this function for ircoff alias
function ircoff(){
  clear && br 2 && sudo clear;
  sudo service inspircd stop;
  irth;
}

#######################################################################

### p10k Config

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#######################################################################
