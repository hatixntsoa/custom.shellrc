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

# Default editor used by crontab
DEFAULT_EDITOR=$(which nvim || which vim || which nano)

export EDITOR="$DEFAULT_EDITOR"
export VISUAL="$DEFAULT_EDITOR"

# Oh-My-Zsh custom theme
ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME="archcraft"

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

### WSL Environment Variables

source ~/.shellrc_env/env/shortcuts.sh
source ~/.shellrc_env/env/screen.sh
source ~/.shellrc_env/env/paths.sh
source ~/.shellrc_env/env/pwa.sh

#######################################################################

### WSL Paths

PATH=$PATH:$PYTHON_PATH:$PYTHON_PACKAGES_PATH

#######################################################################

### Basic Aliases

# this alias to update the package
alias upd="allow_sudo && upd"

# this function for up alias
function upd {
  echo "u p d a t i n g .  .  ." | figlet -t -c;
  br && sudo apt update && br;
}

# this alia to update the package
alias upg="allow_sudo && upg"

# this function for up alias
function upg {
  echo "u p g r a d i n g . . ." | figlet -t -c;
  br && sudo apt upgrade && br;
}

# this alias to install package
alias ist="allow_sudo && ist"

# this function for ist alias
function ist {
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
function rmv {
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
function nm {
  mv "$1" "$2" && cv;
}

# this line to count line inside a file
alias cl="linecount"

# this function for the cl alias
function linecount {
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
function mn {
  if [[ $# -eq 1 ]]; then
    man $1 | less
  else
    man $1 | grep $2 | less
  fi
}

# this alias to view the history
alias hst="hst"

# this function for hst alias
function hst {
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
function hsg {
  if [[ $# -eq 0 ]]; then
    history | less && cv;
  else
    history | grep "$1" | less && cv;
  fi
}

# this alias to count line and words inside a file
alias flc="flc"

# this function for the cl alias
function flc {
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

      if command -v exiftool >/dev/null 2>&1; then
        br
        exiftool "$1"
      fi
      br;
    else
      grep -c "$1" "$2" | awk -v var="$1" '{print $1, var, "in it"}'
    fi
  elif [[ -d "$1" ]]; then
    dc "$1";
  fi
}

kill-line() {
  if [[ $BUFFER == "" ]]; then
    zle backward-kill-line
  else
    zle kill-whole-line
  fi
}

zle -N kill-line
bindkey "11" kill-line

# this alias to clear
alias c="clear"

# this alias to clear but with extra lines
alias x="clear && echo -e && echo -e && echo -e && echo -e && echo -e && echo -e"

# Clear screen at startup
# x

# Enable MOTD message at startup
# Edit it inside /etc/update-motd.d/10-uname
run-parts /etc/update-motd.d

# this alias to break a line
alias br="br"

# this function for br alias
function br {
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
function cvii {
  clear && br 2;
  echo "H    4    7    1    X" | figlet -t -c;
  br 2;
}

# this alias to exit
alias q='exit'

# this alias to give full permission
alias all="all"

# this function for all alias
function all {
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

### Navigation Aliases

# this alias to create a SymLink
alias symlink="symlink"

# this function for symlink alias
function symlink {
  if [ "$#" -eq 0 ]; then
    echo "wrong usage"
  elif [ "$#" -eq 1 ]; then
    ln -s $PWD "$1"
  elif [ "$#" -eq 2 ]; then
    ln -s $PWD/"$1" "$2"
  fi
}

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

# this alias to view inside a file
alias vf="vf"

# this function for vf alias
function vf {
  if [[ -f "$1" ]]; then
    if [[ "$DISPLAY" == ":0" ]]; then
      case "${1##*.}" in
        csv|mkv|vnc|db|sqlite*|xlsx|docx|pptx|ppt|wmv|pcapng|pdf|jpg|png|JPG|PNG|lnk|docx|xslsx|pptx|mp*|zip|rar|gns3|rdp)
          explorer.exe "$1"
          ;;
        # open all files that have default app with windows explorer
        html)
          if [[ "$PWD" == "/mnt/"* ]]; then
            explorer.exe "$1"
          else
            bwsop "$1"
          fi
          ;;
        # fxml)
        #   cmd.exe /c start SceneBuilder.exe "$@"
        #   ;;
        *) nvim "$1" ;;
      esac
    else
      case "${1##*.}" in
        html|vnc|db|sqlite*|xlsx|docx|pptx|ppt|wmv|pcapng|pdf|jpg|png|JPG|PNG|lnk|docx|xslsx|pptx|mp*|zip|rar|gns3|rdp)
          xdg-open "$1"
          ;;
        *) nvim "$1" ;;
      esac
    fi
    return 0
  elif [[ -d "$1" ]]; then
    op "$1"
  fi
}

# this alias to open a directory
alias op="op"

# this function for op alias
function op {
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
function dr {
  mkdir "$@" && cv;
}

# this alias to remove a directory
alias rd="rd"

# this function for rd alias
function rd {
  rm -r "$@" && cv;
}

# this line to have destination location for copy / cut
alias dt="dt"

# this function for dst alias
function dt {
  dest="$PWD" && c && echo -e && echo "d e s t   s a v e d" | figlet -t -c && sleep 0.6 && cv;
}

# this alias to open a directory
# and make it as destination
alias opd="opd"

# this function for opd alias
function opd {
  op "$1" && dt && nd;
}

# this alias to create a directory
# and then directly enter to it
alias opdr="opdr"

# this function for opdr alias
function opdr {
  dr "$*" && op "$*";
}

# this alias to go back from a directory
alias b="b"

# this function for b alias
function b {
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
function nd {
  [[ -n "$dest" ]] && \
    cd $dest || \
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
function allow_sudo {
  sudo -n true &>/dev/null
  if [ $? -eq 1 ]; then
    sudo echo && return 0 || return 1
  fi
  return 0
}

# this alias to simulate the sudo behaviour
alias hndo="hndo"

# this function for hndo alias
function hndo {
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
function ad {
  c && echo -e && echo -e && sudo su && cv;
}

#######################################################################

### $SHELLrc Aliases

# this alias to edit $SHELLrc
alias ct="nvim ~/.zshrc"

# this alias to reload the zshrc file
alias rld="rld"

# this function for rld alias
function rld {
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
function nvm {
  nvim "${1:-.}";
}

# this alias to call neovim in a cooler way
alias hnvim="nvim"

# this alias to open nvim as root
alias nvmr="allow_sudo && nvmr"

# this function for nvmr alias
function nvmr {
  sudo \
    PATH=$PATH:$SYSTEM32_PATH \
    nvim "${1:-.}"
}

# this alias to edit a file
alias ed="ed"

# this function for ed alias
function ed {
  # nvim -c "startinsert" "$1" && cv;
  nvim "$1" && cv;
}

#######################################################################

### WSL Kex

# this function to check if
# we use kex server screen
function check_kex {
  [[ "$DISPLAY" == "$WINDOWS_SCREEN" ]] \
    && return 1 || return 0
}

#######################################################################

### WSL Shortcuts

# this alias to go to home directory
alias hm="cd && cv"

# this alias to access Desktop
alias dtp="op ~/Desktop"

# this alias to access ENI directory
alias eni="op $ENI_PATH"

# this alias to open the Dev directory
alias dev="op $DEV_PATH"

# this alias to open learning directory
alias learn="op $DEV_PATH/learning"

# this alias to open Notes directory
alias nt="op $DEV_PATH/notes"

# this alias to view the pc state
alias pc="c && br 2 && neofetch --source $CUSTOM_NEOFETCH"

#######################################################################


### WSL Programs

# CREATED : 10-24-2024 19:19
# this alias to forcefully
# run a windows command inside
# WSL by temporarely move to C drive
alias force_run="force_run"

# this function for force_run alias
function force_run(){
  if [[ "$PWD" != "/mnt/"* && ! -L "$PWD" ]]; then
    cd /mnt/c
    eval "$@"
    cd - &>/dev/null
  else
    eval "$@"
  fi
}

# this alias to not mess up vscode
alias code="code"

# this function for code alias
function code {
  if [[ "$DISPLAY" == ":0" ]]; then
    cmd.exe /c code "$@"
  else
    /usr/bin/code-oss "$@" &>/dev/null
  fi
}

# this function to open windows app
function open_win_app {
  if [[ "$DISPLAY" != ":0" ]]; then
    echo "Sorry, this is not a Linux app !"
    return 0
  fi

  local APP_PATH="$1"
  local EXECUTABLE="$2"

  explorer.exe "$(wslpath -w $APP_PATH)\\$EXECUTABLE.exe"
  return 0
}

# this function to run windows CLI app
function run_win_app {
  local APP_CLI_PATH="$1"
  local PROGRAM="$2"
  local old_path="$PWD"

  cd /mnt/c
  echo "$APP_CLI_PATH"
  echo "$(wslpath -w "$APP_CLI_PATH")"

  cmd.exe /c "$(wslpath -w "$APP_CLI_PATH")"\\$PROGRAM.exe "$@"
  cd $old_path
  return 0
}

# this function to open kali-win-kex
function vm {
  kex --esm -s &>/dev/null
  return 0
}

# Open new tab inside windows terminal
# cmd.exe /c wt -w 0 nt

# tasklist | findstr "Docker"
#
# taskkill /IM "Docker Desktop.exe" /F

# Stop-Process -Name "Docker Desktop" -Force

# cmd.exe /c wt -w 0 nt && sudo openvpn /home/h471x/Desktop/tryhackme_ctf/thm_openvpn/thm_h471x.ovpn
#
# twitter link https://t.co/OSGeowHZ7G
#
# window terminal new tab : cmd.exe /c wt -w 0 nt

# this function to run docker
# function docker {
#   # Check if Docker Service is not running
#   if ! cmd.exe /c "tasklist | findstr Docker" &>/dev/null; then
#     echo "didn't find docker"
#     return 0
#     # # Cannot start docker inside kali-win-kex
#     # if [[ "$DISPLAY" != ":0" ]]; then
#     #   echo "Please start docker service inside Windows Terminal first !"
#     #   return 0
#     # fi
#     #
#     # # Debugging message
#     # echo "Starting docker desktop ..."
#     #
#     # # Start the docker service
#     # open_win_app $DOCKER_DESKTOP_PATH "Docker Desktop"
#   fi
#
#   # run the default docker
#   # command integration for WSL2
#   $DOCKER_DESKTOP_PATH/resources/bin/docker "$@"
# }

# this function to open virtual box
function vbox {
  open_win_app $VIRTUAL_BOX_PATH VirtualBox
}

# this function to launch apple music
function music {
  force_run cmd.exe /c start AppleMusic.exe
}

# this function to run bluestacks
function android {
  open_win_app $BLUESTACKS_PATH HD-Player
}

# this function to run Adobe Photoshop
function aps {
  open_win_app $PHOTOSHOP_PATH Photoshop
}

# this function to open GNS3
function gns {
  open_win_app $GNS3_PATH gns3
}

# this function to launch MuseScore
function msc {
  open_win_app $MUSESCORE_PATH MuseScore4
}

# this function to launch Office Word
function word {
  open_win_app $MICROSOFT_OFFICE_PATH WINWORD
}

# this function to launch Office Excel
function xls {
  open_win_app $MICROSOFT_OFFICE_PATH EXCEL
}

# this function to launch Office Powerpoint
function ppt {
  open_win_app $MICROSOFT_OFFICE_PATH POWERPNT
}

# this function to launch Office Access
function acc {
  open_win_app $MICROSOFT_OFFICE_PATH MSACCESS
}

# this function to open FL Studio
function fl {
  open_win_app $FL_STUDIO_PATH FL64
}

# this function to open x64 debug program
function dbg {
  open_win_app $X64_DBG_PATH x64dbg
}

# this function to open wireshark
function wsh {
  open_win_app $WIRESHARK_PATH Wireshark
}

# this function to open BurpSuite
function burp {
  open_win_app $BURPSUITE_PATH BurpSuiteCommunity
}

# this function to launch mobaXterm
function moba {
  open_win_app $MOBAXTERM_PATH MobaXterm
}

# this function to open Wub
function wub {
  open_win_app $WUB_PATH Wub_x64
}

# this function to open tor browser
function tor {
  open_win_app $TOR_PATH tor
}

# this function to open total commander
function tcmd {
  open_win_app $TOTAL_CMD_PATH TOTALCMD64
}

# this function to launch canva
function canva {
  open_win_app $CANVA_PATH Canva
}

# this function to launch usbipd
function usbipd {
  # run_win_app $USBIPD_PATH usbipd "$@"
  old_path="$PWD"
  cd /mnt/c
  cmd.exe /c usbipd "$@"
  cd $old_path
}

# this alias to start screen recording
# using windows OBS Studio
alias obs="obs"

# this function for obs alias
function obs {
  # change directory
  cd $OBS_PATH

  # Check if OBS is running
  if cmd.exe /c "tasklist | findstr obs64.exe" &>/dev/null; then
    cmd.exe /c "taskkill /IM obs64.exe /F"
  fi

  # Minimize all windows
  powershell.exe -command \
    "(New-Object -ComObject Shell.Application).MinimizeAll()"

  # start recording on OBS
  cmd.exe /c start obs64.exe \
    --startrecording \
    --multi \
    --allow-multiple-instances

  # get back to the old directory
  cd - &>/dev/null

  # clear terminal
  cv
}

#######################################################################

### WSL Browser

# SOLVED :
# this to make Github CLI know which default browser it would use
# this WSL issue was solved in gh GitHub Repo Pull Request
export BROWSER="brave.exe"

# this alias to open file with browser
alias bwsop="bwsop"

# SOLVED : no need for this annoying code
# since we only use Windows Explorer to
# open files according to their default apps
# and there is no lag like we did here
# IMPROVED : 06-18-2024 21:44
# Handled the shell access after launch
#
# this function bwsop alias
function bwsop {
  local file_name="$1"
  local file_extension="${file_name##*.}"
  local current_directory="$PWD"

  # check if we want to open a link instead
  if [[ ! -f "$current_directory/$file_name" ]]; then
    brave.exe "$file_name"
    return 0
  fi

  # Replace all Spaces and Back-slashes with %20
  local formatted_path=$(wslpath -m . | sed -e 's/ /%20/g' -e 's/\\//g')
  local formatted_file=$(echo "$file_name" | sed -e 's/ /%20/g' -e 's/\\//g')

  # Check if it a Pdf file
  local isPdf="[[ "$file_extension" == "pdf" ]]"

  # Open Pdf file with edge and the other files with chrome
  local browser=$( eval $isPdf && echo msedge.exe || echo brave.exe)

  # if the current directory is a WSL
  # directory then switch to windows
  # directory before executing the script
  if [[ "$current_directory" != "/mnt/"* ]]; then
    cd /mnt/c
  fi

  # Open the file with the browser
  cmd.exe /c start $browser file:///$formatted_path/$formatted_file

  # if we changed directory then get back
  if [[ "$PWD" != "$current_directory" ]]; then
    cd - &>/dev/null
  fi

  return 0
}

#######################################################################

### WSL PWA Alias

# HTX:
# this alias to open web app
alias open_web_app="allow_sudo && open_web_app";

# CREATED :  02-11-2024 20:13
# this function to open chrome based app
# it uses the Id of the App we created within
# the Chrome browser, it will take 3 arguments :
# first the domain of the App
# then the chrome App Id
# finally the name of the App (optional)
# NOTE : 08-26-2024 11:28
# This is just PWA that can
# be installed in whatever browser
# IMPROVED : 05-30-2024 18:36
# Shell access after execution
# UPDATED : 12-09-2024 18:35
# Open PWAs using shortcuts instead
# UPDATED : 12-16-2024 16:14
# Multiple Browser
function open_web_app {
  if [[ "$DISPLAY" != ":0" ]]; then
    echo "Sorry, this is not a Linux app !"
    return 0
  fi

  local browser="$1"
  local app_domain="$2"
  local app_name="$3"

  # Access the array using the correct Zsh syntax
  local pwa_base_path="${BROWSER_PATHS[\"$browser\"]}"

  # Check if the browser path exists
  if [ -z "$pwa_base_path" ]; then
    echo "${BOLD} The browser path for $browser doesn't exist in the array! ${RESET}"
    return 0
  fi

  local pwa_path="$pwa_base_path/$app_name.lnk"
  local pwa_path_windows="$(wslpath -w "$pwa_base_path")\\$app_name.lnk"

  if [ ! -f "$pwa_path" ]; then
    echo "$pwa_path"
    echo "${BOLD} The shortcut for $app_name PWA doesn't exist! ${RESET}"
    return 0
  fi

  local current_directory="$PWD"
  local check="sudo ping -c 1 -W 5"
  local check_message="Checking $app_name ..."
  local reachable="c && br && echo ' $check_message' && eval $check $app_domain &> /dev/null;"

  # Change to Windows directory if in a WSL directory
  if [[ "$current_directory" != "/mnt/"* ]]; then
    cd /mnt/c
  fi

  # Function to open the shortcut
  function open_app {
    explorer.exe "$pwa_path_windows"
    return 0
  }

  # Function to display the web app status
  function web_app_stat {
    c && br
    echo " WebApp  : $app_name"
    echo " Link    : $app_domain"
    echo " Browser : ${browser:l}.exe"
    echo " Status  : $1"
  }

  # Check connection status
  if eval "$reachable"; then
    web_app_stat "Connected"
  else
    web_app_stat "Not Connected"
  fi

  # Call the open_app function
  open_app

  # Return to original directory if it was changed
  if [[ "$PWD" != "$current_directory" ]]; then
    cd - &>/dev/null
  fi

  return 0
}

function open_chrome_app {
  open_web_app "CHROME" "$1" "$2"
}

function open_brave_app {
  open_web_app "BRAVE" "$1" "$2"
}

# this function to open a link as PWA window
function open_link {
  local app_link="$1"
  old_path="$PWD"
  cd /mnt/c

  cmd.exe /c start brave.exe \
    --profile-directory=Default \
    --app=$app_link

  cd $old_path
}

#######################################################################

### PWAs Aliases

# this alias to recharge the router
alias rtr='open_chrome_app "www.airtel.mg" "Airtel Router"'

# this alias to view the HTX_AP dashboard
alias htx="open_chrome_app 192.168.8.1 HTX_AP"

# this alias to open Try Hack Me Web app
alias thm="thm"

# this function for thm alias
function thm {
  dest="$PWD"
  cd /mnt/c

  if [[ "$1" == "connect" ]]; then
    cmd.exe /c start openvpn-gui \
      --command silent_connection 1

    cmd.exe /c start openvpn-gui \
      --command connect thm_h471x
  elif [[ "$1" == "disconnect" ]]; then
    cmd.exe /c start openvpn-gui \
      --command disconnect thm_h471x
  elif [[ "$1" == "status" ]]; then
    local check="ping -c 1 -W 5 "
    local check_message="Checking TryHackMe Connectivity ..."
    local reachable="echo ' $check_message' && eval $check tryhackme &> /dev/null;"

    if eval $reachable; then
      echo " ${GREEN}Connected ${RESET}to TryHackMe OpenVPN"
    else
      echo " ${RED}Disconnected ${RESET}from TryHackMe OpenVPN"
    fi
  else
    open_chrome_app tryhackme.com TryHackMe
  fi

  # get back to the old directory
  cd $dest
}

# this alias to open Pwned Labs Web App
# AWS Learning Platform
alias pwn="pwn"

# this function for pwn alias
function pwn {
  dest="$PWD"
  cd /mnt/c

  if [[ "$1" == "connect" ]]; then
    cmd.exe /c start openvpn-gui \
      --command silent_connection 1

    cmd.exe /c start openvpn-gui \
      --command connect pwndlb_h471x
  elif [[ "$1" == "disconnect" ]]; then
    cmd.exe /c start openvpn-gui \
      --command disconnect pwndlb_h471x
  elif [[ "$1" == "status" ]]; then
    local check="ping -c 1 -W 5 "
    local check_message="Checking Pwned Labs Connectivity ..."
    local reachable="echo ' $check_message' && eval $check pwnedlb &> /dev/null;"

    if eval $reachable; then
      echo " ${GREEN}Connected ${RESET}to Pwned Labs OpenVPN"
    else
      echo " ${RED}Disconnected ${RESET}from Pwned Labs OpenVPN"
    fi
  else
    open_chrome_app pwnedlabs.io PwnedLabs
  fi

  # get back to the old directory
  cd $dest
}

# this alias to open chatGpt app
alias gpt="open_chrome_app chatgpt.com ChatGPT"

# this alias to open LinkedIn WebApp
alias lnk="open_link https://linkedin.com/feed"

# this alias to open MOCC App
alias mocc="open_link https://moocs.openenglishprograms.org"

# this alias to open Facebook app
alias fb="open_brave_app facebook.com Facebook"

# this alias to open Instagram app
alias itg="open_chrome_app instagram.com Instagram"

# this alias to open TwitterX app
alias twx="open_brave_app x.com X"

# this alias to open CloudFlare
alias flare="open_chrome_app cloudflare.com Cloudflare"

# this alias to open Exploit Database
alias xdb="open_brave_app exploit-db.com ExploitDB"

# this alias to open Discord
alias dsc="open_chrome_app discord.com Discord"

# this function to open ascii art archive
alias ascii="open_link https://www.asciiart.eu/logos"

# this function to open CloudConvert
alias conv="open_chrome_app cloudconvert.com CloudConvert"

# this alias to open GTFOBins App
alias gtfo="open_chrome_app gtfobins.github.io GTFOBins"

# this alias to open lolbas
alias lolbas="open_link https://lolbas-project.github.io"

# this alias to open dockerhub
alias dckhb="open_chrome_app docker.com DockerHub"

# this alias to open PyPi App
alias pypi="open_chrome_app pypi.org PyPi"

# this alias to open GitLab
alias gtlb="open_brave_app gitlab.com GitLab"

# this alias to open naga the trading app
alias naga="open_chrome_app nagacap.com Naga"

# this alias to open Trading View
alias trdv="open_chrome_app tradingview.com TradingView"

# this alias to open clock
alias clock="open_chrome_app localhost Clock"

# this alias to open reverse shell generator
alias revshell="open_chrome_app www.revshells.com Revshell"

# this alias to open CrackStation App
alias crack="open_chrome_app crackstation.net CrackStation"

# this alias to open 247 CTF App
alias ctf="open_chrome_app 247ctf.com 247CTF"

# this alias to open Cisco Networking Academy
alias cna="open_chrome_app www.netacad.com 'Cisco Networking Academy'"

# this alias to open YouTube Web App
alias ytb="open_brave_app youtube.com YouTube"

# this alias to open reddit Web App
alias rdt="open_brave_app reddit.com Reddit"

# this alias to open Cybr (AWS CybSec Learning Platform)
alias cybr="open_chrome_app cybr.com Cybr"

# this alias to open HackerRank
alias hcrk="open_chrome_app hackerrank.com HackerRank"

# this alias to open reverse shell generator
alias ipinfo="open_chrome_app ipinfo.io IPInfo"

# this alias to open Virus Total Web App
alias vrst="open_chrome_app virustotal.com VirusTotal"

# this alias to open Gmail WebApp
alias gmail="open_link https://gmail.com"

# this alias to open Proton Mail
alias pmail="open_brave_app mail.proton.me ProtonMail"

# this alias to open ProtonDrive
alias pdrive="open_brave_app drive.proton.me ProtonDrive"

# this alias to open ProtonVPN
alias pvpn="open_link https://account.proton.me/u/0/vpn"

# this alias to open udemy
alias udemy="open_link https://www.udemy.com"

# this alias to open google drive
alias drive="open_link https://drive.google.com"

# this alias to open StackOverFlow
alias stk="open_chrome_app stackoverflow.com StackOverflow"

#######################################################################

### GitHub Alias

# this alias to open the GitHub app
alias gthb="gthb"

# this function for gthb alias
function gthb {
  if [[ "$DISPLAY" != ":0" ]]; then
    echo "Sorry, this is not a Linux app !"
    return 0
  fi

  local is_a_git_repo=$(git rev-parse --is-inside-work-tree 2>/dev/null)

  local github_link="github.com"
  local github_name="GitHub"

  if [[ "$is_a_git_repo" == "true" ]]; then
    local has_remote=$(git remote -v)
    if [ "$has_remote" ]; then
      local repo_url=$(git config --get remote.origin.url)
      local repo_owner=$(echo "$repo_url" | awk -F '[/:]' '{print $(NF-1)}')
      local repo_name="$(echo "$repo_url" | awk -F '/' '{print $NF}' | sed 's/.git$//')"
    else
      local repo_owner=$(git config user.username)
      local repo_name=$(basename "$(git rev-parse --show-toplevel)")
    fi

    local current_branch=$(git branch | awk '/\*/ {print $2}');

    function check_view {
      echo -ne "${BOLD}${GREEN}Open ${WHITE}the repo ${LIGHT_BLUE}$repo_name ${WHITE}on GitHub ? (y/n) ";
      read check_view
      echo ${RESET}

      if [ "$check_view" = "y" ]; then
        cd /mnt/c

        cmd.exe /c start brave.exe \
          --profile-directory=Default \
          --app=https://github.com/$repo_owner/$repo_name/tree/$current_branch

        cd - &>/dev/null
        # gh repo view $repo_owner/$repo_name \
        #   --web --branch $current_branch \
        #   &>/dev/null
      elif [ "$check_view" = "n" ];then
        open_chrome_app $github_link $github_name
      else
        check_view
      fi
    }

    # check if the repo has a remote
    # on github otherwise open the pwa
    if [ "$has_remote" ]; then
      # Fetch updates from the remote to ensure up-to-date branch info
      git fetch --quiet origin

      local is_remote_branch=$(git branch -r | grep "origin/$current_branch")

      # check if the current branch has remote
      if [ -n "$is_remote_branch" ]; then
        check_view
      else
        echo "${BOLD} The remote repo ${LIGHT_BLUE}$repo_name ${WHITE}has no branch named ${GREEN}$current_branch ${WHITE}!" && br;
      fi
    else
      open_brave_app $github_link $github_name
    fi
  else
    if [[ $# -eq 0 ]]; then
      open_brave_app $github_link $github_name
    fi
  fi
}

#######################################################################

### WSL Terminal Aliases

# this alias to switch to windows terminal
alias wds="wds"

# this function for wds alias
function wds {
  c && br 2;
  # Check the current directory
  # because cmd will work only
  # on windows'directory rather
  # than WSL's one so we move
  if [[ "$PWD" == "/mnt/"* ]]; then
    cmd.exe;
  else
    cd /mnt/c
    cmd.exe;
    cd - &>/dev/null
  fi
  cv;
}

# this alias to switch to powershell terminal
alias pws="pws"

# this function for pws alias
function pws {
  c && br 2;
  powershell.exe;
  cv;
}

# this alias to enter cmd as admin
alias cmd="cmd"

# this function for cmd alias
function cmd {
  powershell.exe -command "Start-Process cmd -Verb RunAs";
  x;
}

#######################################################################

### WSL Network Aliases

# this function to prompt for input
# with regex matching check
function check_input {
  # Remove the debug print statement
  # echo "check_input called"

  local input_message="$1"
  local input

  # Prompt user for input
  echo -ne "$input_message"
  read input

  # Return the valid input
  echo "$input"
}

# this alias to add host
alias add_host="allow_sudo && add_host"

# Function to add hosts interactively
function add_host {
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

  # Add to windows host if we use
  # windows terminal
  if [[ "$DISPLAY" == ":0" ]]; then
    powershell.exe -Command "Start-Process -FilePath 'powershell.exe' -ArgumentList \"-Command Add-Content -Path 'C:\\Windows\\System32\\drivers\\etc\\hosts' -Value '\`n# $description\`n$host $redirection'\" -Verb RunAs -WindowStyle Hidden"
  fi

  # Add to WSL2 host
  sudo echo -e "\n# $description\n$host $redirection" \
    | sudo tee -a /etc/hosts > /dev/null
}

# this alias to edit windows host
alias winhost="winhost"

# this function for winhost alias
function winhost {
  if [[ "$DISPLAY" != ":0" ]]; then
    echo "Sorry, this is not a Linux app !"
    return 0
  fi

  old_path="$PWD"
  cd "$(dirname "$(wslpath "$WINDOWS_HOSTS_PATH")")"
  cmd.exe /c sudo notepad "$WINDOWS_HOSTS_PATH"
  cd $old_path
}

# this alias to edit Winux Hosts
alias hosts="nvmr /etc/hosts"

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

  # Find the length of the longest interface name (after stripping quotes and colons)
  longest_iface_length=$(echo "$map_output" | sed -E 's/"([^"]+)":.*/\1/' | awk '{ print length }' | sort -n | tail -n 1)

  # Loop through each line of the map_output, stripping quotes from iface and aligning
  while IFS=: read -r iface ip; do
    iface=$(echo "$iface" | tr -d '"')  # Remove any quotes from iface
    iface=$(echo "$iface" | tr -d ' ')  # Remove any extra spaces from iface

    # Calculate how many spaces need to be added to align the '==>'
    spaces_to_add=$((longest_iface_length - ${#iface}))

    # Only add spaces if spaces_to_add is greater than 0
    if (( spaces_to_add > 0 )); then
      padded_iface="$iface$(printf ' %.0s' {1..$spaces_to_add})"
    else
      padded_iface="$iface"
    fi

    # Print the iface and ip, ensuring alignment of '==>'
    echo "$padded_iface ==> $ip"

    # Future Feature
    #  ipconfig.exe | grep -A 5 "OpenVPN TAP" | grep "IPv4 Address" | awk '{print $NF}'
  done <<< "$map_output"

  br
}

function clean_argument {
  local arg="$1"

  # Replace spaces with backslashes
  local clean_arg="${arg// /\\}"

  # Replace special characters with escaped versions
  local special_chars='[][{}()*+?.\\^$|]'
  # Escape backslashes for sed
  local escaped_special_chars="$(echo "$special_chars" | sed 's/\\/\\\\/g')"
  local arg_pattern="s/[$escaped_special_chars]/\\\\&/g"

  clean_arg="$(echo "$clean_arg" | sed -E "$arg_pattern")"
  echo "$clean_arg"
}

# I don't know why but this alias
# make the PC slow down
# this alias to view saved wifi password
# SOLVED: 05-11-2024 22:44
# Just execute it inside the
# hard drive of windows instead of WSL
# directories, so just cd to whatever
# hard drive of windows to make it run
alias wpass="wpass"

# this function for wpass alias
function wpass {
  cd /mnt/c
  if [[ $# -eq 0 ]]; then
    # consider all arguments as one string
    local wifi=$(
      cmd.exe /c netsh wlan show profiles |
        grep -i "All User Profile" |
        awk '{print $5}' | shuf -n 1
    )
    local password=$(
      cmd.exe /c netsh wlan show profiles "$wifi" key=clear |
        grep "Key Content" |
        awk '{print $4}'
    )
    echo "Wifi SSID : $wifi";
    echo "Password  : $password";
  else
    # consider all arguments as one string
    local wifi="$*"
    local password=$(
      cmd.exe /c netsh wlan show profiles "$wifi" key=clear |
        grep "Key Content" |
        awk '{print $4}'
    )
    echo "Wifi SSID : $wifi";
    echo "Password  : $password";
  fi
  cd - &>/dev/null;
}

# Completion function for wpass
_wpass_completion() {
  cd /mnt/c
  local cur

  # Get the current word being completed
  cur="${COMP_WORDS[COMP_CWORD]}"

  # Fetch WiFi profiles
  local profiles=$(cmd.exe /c netsh wlan show profiles |
    grep -i "All User Profile" |
    awk '{$1=$2=$3=""; print substr($0, 6)}' |
    head -n 1000
  )

  # Generate completions
  COMPREPLY=($(compgen -W "${profiles}" -- "${cur}"))
  cd - &>/dev/null
}

# Register the completion function for wpass
complete -F _wpass_completion wpass

# this alias to "list known wifi"
alias wls="wls"

# this function for wls alias
function wls {
  cd /mnt/c

  function print_message {
    wifi="$1"
    password="$2"
    # Print Wi-Fi SSID and password
    echo "Wifi SSID : $wifi"
    echo "Password  : $password"
    echo
  }

  function wifi_and_pass {
    num_profiles="$1"
    grep_string="$2"
    # Loop through each Wi-Fi profile
    while IFS= read -r wifi; do
      # Retrieve password for the current Wi-Fi profile
      local password=$(
        cmd.exe /c netsh wlan show profiles "$wifi" key=clear |
          grep "Key Content" | awk '{print $4}'
      )
      print_message $wifi $password
    done < <(
      cmd.exe /c netsh wlan show profiles |
        grep -i "$grep_string" |
        grep 'All User Profile' |
        awk '{$1=$2=$3=""; print substr($0, 6)}' |
        head -n "$num_profiles"
    )
  }

  function wifi_name {
    wifi_count=0
    # Loop through each Wi-Fi profile
    while IFS= read -r wifi; do
      echo "- $wifi"
      ((wifi_count++))
    done < <(
      cmd.exe /c netsh wlan show profiles |
        grep 'All User Profile' |
        awk '{$1=$2=$3=""; print substr($0, 6)}'
    )
  }

  if [[ $# -eq 0 ]]; then
    num_profiles=1
    grep_string=$(
      cmd.exe /c netsh wlan show profiles |
        grep -i "All User Profile" |
        awk '{print $5}' | shuf -n 1
    )
    wifi_and_pass $num_profiles $grep_string
  elif [[ $# -eq 1 ]]; then
    if [[ "$1" =~ ^[0-9]+$ ]]; then
      num_profiles=$1
      grep_string=""
      wifi_and_pass $num_profiles $grep_string
    elif [[ "$1" != "-a" ]]; then
      num_profiles=99999999
      grep_string="$1"
      wifi_and_pass $num_profiles $grep_string
    elif [[ "$1" -eq "-a" ]]; then
      wifi_name
      echo
      echo "Known Wi-Fi Connections ($wifi_count) "
    fi
  fi

  cd - &>/dev/null;
}

# this alias to reach a network
alias reach="allow_sudo && reach";

# this function to check if pfsense is reachable
# coded 01/29/2024
function reach {
  c && br;

  local target_IP="$1"
  local check_message="Checking $target_IP reachability..."
  local check_IP="sudo ping -c 1 -W 5 "
  local reachable="br && echo ' $check_message' && eval $check_IP $target_IP &> /dev/null;"
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

### Services Aliases

# this alias to start services
alias svc_on="allow_sudo && svc_on"

# this function for svc_on alias
function svc_on {
  sudo service "$1" start;
}

# this alias to stop systemctl based services
alias svc_off="allow_sudo && svc_off"

# this function for svc_off alias
function svc_off {
  sudo service "$1" stop;
}

# this alias to view systemctl
# based services status
alias svc_stat="allow_sudo && svc_stat"

# this function for svc_stat alias
function svc_stat {
  sudo service "$1" status;
}

# this alias to show if a service if on or off
alias svc_show_stat="allow_sudo && svc_show_stat"

# this function for svc_show_stat alias
function svc_show_stat {
  br;

  local service_name="$1";
  local check_command="$2";

  if [[ "$check_command" == *"Active: active"* ]]; then
    echo "${BOLD}$service_name Active ${BOLD}${GREEN} ${RESET}";
  elif [[ "$check_command" =~ ^[0-9]+$ ]]; then
    echo "${BOLD}$service_name Active ${BOLD}${GREEN} ${RESET}";
  else
    echo "${BOLD}$service_name Off ${BOLD}${RED}✘ ${WHITE}";
  fi

  br;
}

# this alias to view the ssh server status
alias sth="sth"

# this function for sth alias
function sth {
  c && br;
  if [[ $(pgrep sshd) ]]; then
    c && br;
    echo "${BOLD}Ssh Server Active ${BOLD}${GREEN} ${RESET}"
    br;

    # Capture the output of show_ip
    map_output=$(show_ip)

    # Find the length of the longest interface name (after stripping quotes and colons)
    longest_iface_length=$(echo "$map_output" | sed -E 's/"([^"]+)":.*/\1/' | awk '{ print length }' | sort -n | tail -n 1)

    # Loop through each line of the map_output, stripping quotes from iface and aligning
    while IFS=: read -r iface ip; do
      iface=$(echo "$iface" | tr -d '"')  # Remove any quotes from iface
      iface=$(echo "$iface" | tr -d ' ')  # Remove any extra spaces from iface

      # Calculate how many spaces need to be added to align the '==>'
      spaces_to_add=$((longest_iface_length - ${#iface}))

      # Only add spaces if spaces_to_add is greater than 0
      if (( spaces_to_add > 0 )); then
        padded_iface="$iface$(printf ' %.0s' {1..$spaces_to_add})"
      else
        padded_iface="$iface"
      fi

      # Print the iface and ip, ensuring alignment of '==>'
      echo "${BOLD}${WHITE}$padded_iface ==> ssh $USER@$ip";
    done <<< "$map_output"

  else
    echo "${BOLD}Ssh Server Off ${BOLD}${RED}✘ ${WHITE}"
  fi
}

# this alias to enable the ssh server
alias sshon="allow_sudo && sshon"

# this function for sshon alias
function sshon {
  local is_wsl=$(grep -qi microsoft /proc/version && echo true || echo false)

  if $is_wsl; then
    sudo service ssh start &>/dev/null;
  else
    svc_on ssh;
  fi
  sth;
}

# this alias to kill the ssh server process
alias sshoff="allow_sudo && sshoff"

# this function for sshoff alias
function sshoff {
  # sudo /etc/init.d/ssh stop;
  if [[ $(pgrep sshd) ]]; then
    sudo kill $(pgrep sshd);
  fi
  sth;
}

# this function to view the current apache2
# service, its status
function stap {
  c && br;
  if [[ $(pgrep apache2) ]]; then
    echo "${BOLD}Apache Server Active ${BOLD}${GREEN} ${RESET}"
    br;

    local eth_iface="eth0"

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
    echo "${BOLD}Apache Server Off ${BOLD}${RED}✘ ${WHITE}"
    br
  fi
}

#######################################################################

### File Aliases

# this alias to create a file
alias tf="tf"

# this function for tf alias
function tf {
  touch "$@" && all "$@" && cv;
}

# this alias to delete file
alias dlf="dlf"

# this function for dlf alias
function dlf {
  rm "$@" && cv;
}

# this alias to copy a file then display it
alias cpf="cpf"

# this function for cpf alias
function cpf {
  if [[ $# -eq 2 ]]; then
    if [[ -d "$1" ]]; then # here to check if the first argument is a directory
      cp -r "$1" "$2" && op "$2" && all "$1";
    else
      cp "$1" "$2" && op "$2" && all "$1";
    fi
  elif [[ $# -eq 1 ]]; then
    if [[ -d "$1" ]]; then # here to check if the first argument is a directory
      cp -r "$1" "$dest" && op "$dest" && all "$1";
    else
      cp "$@" "$dest" && op "$dest" && all "$@";
    fi
  fi
}

# this alias to copy the content of a file
alias cnf="cnf"

# this function for cnf alias
function cnf {
  cat "$1" > "$2" && dlf "$1" && all "$2";
}

# this alias to copy a file then display it
alias mvf="mvf"

# this function for cpf alias
function mvf {
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
function rdf {
  sudo rm -rfv "$@";
  cv;
}

# this alias to count the number of file/directory
# inside a directory
# alias dc="dc"

# #this function for dc alias
# function dc {
#   if [[ $# -eq 0 ]]; then
#     clear;
#     br;
#     case "$(ls -1 | wc -l)" in
#       0)
#         br;
#         echo "There is nothing inside $(basename $PWD)";
#         br;;
#       *)
#         case "$(ls -1 | wc -l)" in
#           1)it="item";;
#           *)it="items";;
#         esac
#         echo "   $(basename $PWD) folder has $(ls -1 | wc -l) $it : ";
#         br;
#         if [[ $(ls -1 | wc -l) -gt 50 ]]; then
#           br;
#         else
#           ls
#         fi
#         br;
#     esac
#   elif [[ $# -eq 1 ]]; then
#     clear;
#     br;
#     case "$(ls -1 $1 | wc -l)" in
#       0)
#         br;
#         echo "There is nothing inside $(basename $1)";
#         br;
#         sleep 1;
#         cv;
#         br;;
#       *)
#         case "$(ls -1 $1 | wc -l)" in
#           1)it="item";;
#           *)it="items";;
#         esac
#         echo "   $(basename $1) folder has $(ls -1 $1 | wc -l) $it : ";
#         br;
#         if [[ $(ls -1 "$1" | wc -l) -gt 50 ]]; then
#           br;
#         else
#           ls "$1";
#         fi
#         br;
#         sleep 1;
#         cv;
#     esac
#   fi
# }

# this alias to know the file type
alias tp="tp"

# this function for tp alias
function tp {
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
# or by the default explorer on Linux
alias exop="exop"

# this function for exop alias
function exop {
  [ $# -eq 1 ] && cd "$1"

  check_kex && \
    xdg-open . || \
    explorer.exe .

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
    echo " ${BOLD}${WHITE}${BOLD}[${RED}x${WHITE}]${WHITE} Command Not Found"
  fi
}

#######################################################################

### Python Aliases

# this alias to launch windows python
alias python="python"

# this function for python alias
# IMPROVED : 10-05-2024 22:28
# Check if the VIRTUAL_ENV is set
# then use python.exe in there
function python {
  if [[ "$DISPLAY" != ":0" ]]; then
    /usr/bin/python3 "$@"
    return 0
  fi

  if [[ "$PWD" != "/mnt/"* ]]; then
    $PYTHON_PATH/python.exe "$@"
  else

    # Check if the script is being run with sudo
    if [[ $EUID -eq 0 ]]; then
      echo "Running with sudo"
      # Create an array to hold arguments for PowerShell
      local arg_list=()

      # Loop through all the provided arguments and escape them correctly
      for arg in "$@"; do
        arg_list+=("\"$arg\"") # Add quotes to each argument
      done

      # Join the array into a single string with commas for PowerShell
      local args_string=$(IFS=, ; echo "${arg_list[*]}")

      powershell.exe -command "Start-Process $(wslpath -w $PYTHON_PATH)\python.exe -ArgumentList $args_string -Verb RunAs"
    fi

    if [[ -n "$VIRTUAL_ENV" ]]; then
      # since I made it hidden handle the leading dot
      local env_dir=$(dirname "$VIRTUAL_ENV")/.$(basename "$VIRTUAL_ENV")
      local python_cmd=$(wslpath -w "$env_dir/Scripts/python.exe")
      cmd.exe /c "$python_cmd" "$@"
    else
      cmd.exe /c python.exe "$@"
    fi
  fi
}

# this function to create a linux python environment
function create_env {
  local env_name="$1"
  python -m venv $env_name
}

# this function to activate a linux python
# environment, a functionality found on
# the activate script
function activate_env {
  # reset the PATH first
  # reset_path

  # get the env name
  local env_name="$1"
  local display_env="${env_name#.}"

  # get the virtual environment
  # this will be displayed on
  # our prompt but the real
  # environment path is given below
  export VIRTUAL_ENV=$PWD/$display_env

  # symlinking the executables
  local scripts_dir="$PWD/$env_name/Scripts"
  local target_dir="/usr/bin"

  # Check if Scripts directory exists
  if [[ -d "$scripts_dir" ]]; then
    for exe_file in "$scripts_dir"/*.exe; do
      # Check if there are .exe files in the directory
      if [[ -e "$exe_file" ]]; then
        # Remove the .exe extension
        local base_name=$(basename "$exe_file" .exe)
        sudo ln -sf "$exe_file" "$target_dir/$base_name"
        # echo "Symlinked $base_name to $target_dir"
      fi
    done
  else
    echo "Scripts directory not found in $scripts_dir"
  fi

  # # handle hidden env
  # local env_dir=$(dirname "$VIRTUAL_ENV")/$env_name

  # # incude the virtual env to path
  # PATH=$env_dir/bin:$PATH
  # export PATH
}

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
    [[ -f "$dir/Scripts/python.exe" ]] && envs+=("$dir")
  done
  echo "${envs[@]}"
}

# this function to remove
# python virtual env from path
function reset_path {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # get the path to VIRTUAL_ENV
    local env_dir=$(dirname $VIRTUAL_ENV)
    local env_name=.$(basename $VIRTUAL_ENV)

    # Remove the env from the path
    export PATH=$(echo $PATH | sed "s|^$env_dir/$env_name/bin:||")
  fi
}

# this function to unset the VIRTUAL_ENV
# global variable and restore the PATH to
# the original one, yet this is the code
# behind python environment deactivate
function disable_env {
  # reset the path
  # reset_path
 
  # get the env path
  local env_path="$(basename $VIRTUAL_ENV)"

  # symlinking the executables
  local scripts_dir="$PWD/.$env_path/Scripts"
  local target_dir="/usr/bin"

  # Check if Scripts directory exists
  if [[ -d "$scripts_dir" ]]; then
    for exe_file in "$scripts_dir"/*.exe; do
      # Check if there are .exe files in the directory
      if [[ -e "$exe_file" ]]; then
        # Remove the .exe extension
        local base_name=$(basename "$exe_file" .exe)
        local target_symlink="$target_dir/$base_name"

        # Check if the symlink exists
        if [[ -L "$target_symlink" ]]; then
          sudo unlink "$target_symlink"
          # echo "Unlinked $target_symlink"
        else
          echo "No symlink found for $base_name in $target_dir"
        fi
      fi
    done
  else
    echo "Scripts directory not found in $scripts_dir"
  fi

  # unset the virtual environment
  unset VIRTUAL_ENV
}

# This function deletes the specified Python virtual
# environment and unsets the VIRTUAL_ENV variable.
function delete_env {
  local env_name="$1"

  dir_name=$(basename "$env_name")
  display_dir="${dir_name#.}"

  echo -ne "${BOLD} Deleting ${LIGHT_BLUE}$display_dir ${WHITE}python environment... ${RESET}"
  rm -rf $dir_name
  echo "${BOLD}${GREEN} ${RESET}"
}

# this alias to create a python environment
# from windows python and activate it
# SOLVED : 10-05-2024 22:23
# Finally I figured it out, I managed to
# display the Windows python virtual environment
# in the Powerlevel10k prompt, no big deal just
# export the VIRTUAL_ENV variable with the path
# of the Windows python virtual environment.
# No need to activate it; Python and pip will automatically
# use the executables in that environment if VIRTUAL_ENV is set.
alias pyenv="allow_sudo && pyenv"

# this function for pyenv alias
function pyenv {
    if [[ $# -eq 0 ]]; then
      if [[ -n "$VIRTUAL_ENV" ]]; then
        # unset VIRTUAL_ENV
        disable_env
      else
        # an array to store the envs
        local envs=($(find_envs))

        if [[ ${#envs[@]} -eq 0 ]]; then
          local env_name=".virenv"
          local display_env="${env_name#.}"

          # creating a new env
          echo -ne "${BOLD} Creating ${LIGHT_BLUE}$display_env ${WHITE}python environment... ${RESET}"
          create_env "$env_name"
          echo "${BOLD}${GREEN} ${RESET}"

          # activating the new env
          echo -ne "${BOLD} Activating ${LIGHT_BLUE}$display_env ${WHITE}environment... ${RESET}"
          activate_env "$env_name"
          echo "${BOLD}${GREEN} ${RESET}"

          return 0
        fi

        if [[ ${#envs[@]} -eq 1 ]]; then
          # activate if it has atched on env
          local env_name=$(basename ${envs[1]})
          local display_env="${env_name#.}"

          echo -ne "${BOLD} Activating ${LIGHT_BLUE}$display_env ${WHITE}environment... ${RESET}"
          activate_env "$env_name"
          echo "${BOLD}${GREEN} ${RESET}"

          # activate_env "$env_name"
        elif [[ ${#envs[@]} -gt 1 ]]; then
          # prompt user to choose the env to activate
          echo "\n${BOLD}${GREEN} Multiple ${WHITE}virtual ${LIGHT_BLUE}environments ${WHITE}found (${#envs[@]}) ${RESET}\n"

          # loop through envs
          for i in {1..${#envs[@]}}; do
            index=$((i))
            dir_name=$(basename "${envs[$index]}")
            display_dir="${dir_name#.}"
            echo "${BOLD}${WHITE} $index) $display_dir ${RESET}"
          done

          # get the choice
          echo -n "\n${BOLD}${WHITE} Your selection : "
          read choice

          # Validate the choice
          if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice > 0 && choice <= ${#envs[@]} )); then
            local index=$((choice))
            local selected_env="${envs[$index]}"
            local env_name=$(basename $selected_env)

            # activate the selected env
            activate_env "$env_name"
            return 0
          else
            echo "Invalid selection."
            return 0
          fi
        fi
      fi
    else
      if [[ "$1" == "delete" ]]; then
        if [[ -n "$VIRTUAL_ENV" ]]; then
          # disable the current env
          # if it has been set
          disable_env
        fi

        # an array to store the envs
        local envs=($(find_envs))

        if [[ ${#envs[@]} -eq 0 ]]; then
          return
        fi

        if [[ ${#envs[@]} -ge 1 ]]; then
          for i in {1..${#envs[@]}}; do
            index=$((i))
            delete_env "${envs[$index]}"
          done
        fi
      else
        local env_name=".$1"
        local display_env="${env_name#.}"

        if [[ -n "$VIRTUAL_ENV" ]]; then
          # disable the current env
          # if it has been set
          disable_env
        fi

        # if it is already an env inside $PWD
        if [[ -d "$PWD/$env_name/Scripts" ]]; then
          export VIRTUAL_ENV=$PWD/$display_env
        else
          # creating a new env
          echo -ne "${BOLD} Creating ${LIGHT_BLUE}$display_env ${WHITE}python environment... ${RESET}"
          create_env "$env_name"
          echo "${BOLD}${GREEN} ${RESET}"

          # activating the new env
          echo -ne "${BOLD} Activating ${LIGHT_BLUE}$display_env ${WHITE}environment... ${RESET}"
          activate_env "$env_name"
          echo "${BOLD}${GREEN} ${RESET}"
        fi
        return 0
      fi
    fi
}

# Alias to call the windows pip
# IMPROVED : 10-05-2024 22:29
# If VIRTUAL_ENV is set we launch the
# pip.exe in there so that every package
# will be installed inside the environment
# instead of the global environment
alias pip="pip"

# Function for pip alias
function pip {
  if [[ "$DISPLAY" != ":0" ]]; then
    /usr/bin/pip3 "$@"
    return 0
  fi

  # Check if we are inside WSL directory or a symbolic link
  if [[ "$PWD" == "/mnt/"* || -L "$PWD" ]]; then
    if [[ -n "$VIRTUAL_ENV" ]]; then
      # since I made it hidden handle the leading dot
      local env_dir=$(dirname "$VIRTUAL_ENV")/.$(basename "$VIRTUAL_ENV")
      local pip_cmd=$(wslpath -w "$env_dir/Scripts/pip.exe")
      cmd.exe /c $pip_cmd "$@"
    else
      cmd.exe /c pip "$@"
    fi
  else
    cd /mnt/c
    if [[ -n "$VIRTUAL_ENV" ]]; then
      # since I made it hidden handle the leading dot
      local env_dir=$(dirname "$VIRTUAL_ENV")/.$(basename "$VIRTUAL_ENV")
      local pip_cmd=$(wslpath -w "$env_dir/Scripts/pip.exe")
      cmd.exe /c $pip_cmd "$@"
    else
      cmd.exe /c pip "$@"
    fi
    cd - &>/dev/null
  fi
}

# this alias to check if a python package
# is already installed or not
alias pycheck="pycheck"

# this function for pycheck alias
function pycheck {
  local package="$1"

  if pip show $package 2>&1 | grep -q "WARNING"; then
    echo -n "${BOLD}${WHITE} Installing ${GREEN}$package ${WHITE}...${RESET}\n"
    pip install $package
  else
    pip show $package
  fi
}

#######################################################################

### p10k Config

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#######################################################################
