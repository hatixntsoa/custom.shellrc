### Powerlevel10k Theme

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# set the default editor
export EDITOR=nvim

#######################################################################

### Minimalistic Theme

# autoload -U colors && colors
# PS1="%B%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}%b \$ "
#
# # This makes ls, grep, diff, etc. use colors automatically
# # (same as "dircolors" in bash)
# if command -v dircolors >/dev/null 2>&1; then
#     # Load dircolors database (Ubuntu/AnduinOS already has it)
#     test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
#
#     # Aliases with forced color output
#     alias ls='ls --color=auto'
#     alias dir='dir --color=auto'
#     alias vdir='vdir --color=auto'
#
#     alias grep='grep --color=auto'
#     alias fgrep='fgrep --color=auto'
#     alias egrep='egrep --color=auto'
#     alias diff='diff --color=auto'
#     alias ip='ip --color=auto'
# fi
#
# # Some extra useful ls aliases (optional but everyone loves them)
# alias ll='ls -alF'
# alias la='ls -A'
# alias l='ls -CF'

#######################################################################

### ZSH Basic Config

set autocd         # change directory just by typing his name
setopt promptsubst # enable command substitution in prompt

# configure keybindings
bindkey -e # emacs keybindings
bindkey ' ' magic-space # do history expansion on space

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Paths
PATH=$PATH:$HOME/.local/bin

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
WHITE="\e[97m"

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

# this alias to clear
alias c="clear"

# this alias to clear but with extra lines
alias x="clear && echo -e && echo -e && echo -e && echo -e && echo -e && echo -e"

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

#######################################################################

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

# this alias to go to home directory
alias hm="cd && cv"

# this alias to access Desktop
alias dtp="op ~/Desktop"

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
  local backup_dir=$HOME/Files/custom.shellrc/$platform;
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

# this function to use img2sixel
# to view image on the terminal
# note that it will only work
# on a real terminal emulator
# but not on android termux
function view {
  if command -v img2sixel >/dev/null 2>&1; then
    img2sixel "$1"
  else
    echo "Please install img2sixel using the command :"
    echo "pkg install libsixel"
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

# this alias to use batcat as bat
alias bat="batcat"

# this alias to copy terminal
# outputs to clipboard
function copy_clipboard {
  local clipboard=$(
      echo "wl-copy"
  )

  [[ "$#" -eq 0 ]] && \
    $clipboard || \
    $clipboard < "$1"
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

# this function to show tree
# using eza if installed
function tree {
  if command -v eza >/dev/null 2>&1; then
    eza -T --icons=always --no-quotes --group-directories-first "$@"
  else
    tree "$@"
  fi
}

# this alias to view files
function vf {
  xdg-open "$1"
}

# this alias to open a directory
alias open="op"

# this function for op alias
function op {
  if [[ "$#" -eq 0 ]]; then
    xdg-open .
    return
  fi

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
  else
    echo -ne "${BOLD}${GREEN}Create ${WHITE}new directory ${LIGHT_BLUE}$1 ${WHITE}? (y/n) ";
    read check_dir
    echo ${RESET}

    if [ "$check_dir" = "y" ]; then
      mkdir "$1" && cd "$1" && cv
    else
      return 0
    fi
  fi
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

# this alias to rename a file / directory; and display it after
alias rnm="rnm"

# this function for cpf alias
function rnm {
  mv "$1" "$2" && cv;
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

# this alias to force delete
alias remove="allow_sudo && rdf"

# this function for rdf alias
function rdf {
  sudo rm -rfv "$@";
  cv;
}

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

# this alias to get the current
# date and time and copy to clipboard
alias rn="rn"

# this function for rn alias
# rn is short for right now btw
function rn {
  local datetime_text=$(date +"%m.%d.%Y %H.%M")
  local date_text=$(date +"%m.%d.%Y")
  local time_text=$(date +"%H.%M")

  if [[ "$1" == "date" || "$1" == "d" ]]; then
    echo $date_text | copy
    echo $date_text
    echo "Date copied to the clipboard."
  elif [[ "$1" == "time" || "$1" == "t" ]]; then
    echo $time_text | copy
    echo $time_text
    echo "Time copied to the clipboard."
  else
    echo $datetime_text | copy
    echo $datetime_text
    echo "Date and Time copied to the clipboard."
  fi
}

#######################################################################

### Python Aliases

# this alias to launch windows python
alias python="python3"

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
    uv --quiet venv --seed .venv
    # here the --seed flag let it copy pip
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

### Network Aliases

# this function to prompt for input
# with regex matching check
function check_input {
  local input_message="$1"
  local input

  # Prompt user for input
  echo -ne "$input_message"
  read input

  # Return the valid input
  echo "$input"
}

# this alias to add new host
alias new_host="allow_sudo && new_host"

# this function for new_host alias
function new_host {
  local host
  local redirection
  local description
  local datetime_text=$(date +"%m.%d.%Y %H.%M")

  # Get the host
  echo -ne " Source Host : "
  read host

  if [[ "$#" -eq 1 ]]; then
    # Display the redirection
    redirection="$1"
    echo " Redirection : $redirection"
  else
    # Get the redirection
    echo -ne " Redirection : "
    read redirection
  fi

  # Get the description
  echo -ne " Description : "
  read description

  # Remove any ANSI escape codes from inputs
  host=$(echo "$host" | sed 's/\x1b\[[0-9;]*m//g')
  redirection=$(echo "$redirection" | sed 's/\x1b\[[0-9;]*m//g')
  description=$(echo "$description" | sed 's/\x1b\[[0-9;]*m//g')

  sudo echo -e "\n# $datetime_text\n# $description\n$host $redirection" \
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

# this alias to edit Winux Hosts
alias hosts="sudo nvim /etc/hosts"

#######################################################################

### p10k Config

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#######################################################################
