# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Make zsh instant prompt quiet
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg='none'
ZSH_HIGHLIGHT_STYLES[precommand]=fg='none'
ZSH_HIGHLIGHT_STYLES[arg0]=fg='none'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg='#23ff45'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg='#23ff45'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#37b0ff,bold'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#37b0ff,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#ffe541,bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#ff9000,bold'

# Add wisely, as too many plugins slow down shell startup.
plugins=(docker zsh-autosuggestions git zsh-syntax-highlighting)

# Here to disable oh-my-zsh auto update
DISABLE_AUTO_UPDATE="true"
source $ZSH/oh-my-zsh.sh

PATH=$PATH:/usr/bin/sqlite3

# this alias to clear but with extra lines
alias x="clear && echo -e && echo -e && echo -e && echo -e && echo -e && echo -e"

# call x alias at startup
x;

#this alias to launch tmux
alias tx="sudo -u h471x tmux && cv"

#this alias to rename the session
alias tmx="tmx"

#this function for tmx alias
function tmx(){
	if sudo -u h471x tmux list-sessions >/dev/null 2>&1 ; then
		sudo -u h471x tmux rename-session "$(basename "$PWD")";
	fi
}

#this alias to access this zshrc file
alias ct="nvim /root/.zshrc && cv"

#this alias to clear
alias c="clear"

#this alias to break a line
alias br="br"

#this function for br alias
function br(){
  if [[ $# -eq 1 ]]; then
    for ((i=1; i<=$1; i++)); do
      echo -e;
    done
  elif [[ $# -eq 0 ]]; then
    echo -e;
  fi
}

# this alias to have the current view
# of working directory content using ls
alias cv="cv"

# this function for cv alias
# updated today 01/25/2024 to adjust the title
# when we have more than 50 visible items
function cv() {
  local target="$1"
  local folder_content="${target:-$PWD}"
  local folder_name=$(basename $folder_content)
  local visible_item=$(ls $folder_content | wc -l)
  local total_item=$(ls -A $folder_content | wc -l)
  local hidden_item=$((total_item - visible_item))

  # this function for the header of cv alias
  function show_header(){
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
  function show_content(){
    # local flag="${1:-}"
    # ls $flag $folder_content;
    eza --icons=always --no-quotes $folder_content
  }

  # this function to show the all of the cv content
  function show_all(){
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
# updated today 01/25/2024 to adjust the title
# when we have more than 50 visible items
function cvf() {
  local target="$1"
  local folder_content="${target:-$PWD}"
  local folder_name=$(basename $folder_content)
  local visible_item=$(ls $folder_content | wc -l)
  local total_item=$(ls -A $folder_content | wc -l)
  local hidden_item=$((total_item - visible_item))

  # this function for the header of cv alias
  function show_header(){
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
  function show_content(){
    eza --icons=always -a $folder_content;
  }

  # this function to show the cv
  function show_all(){
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

#this alias to quit
alias q="clear && exit"

#this alias to give full permission
alias all="all"

#this function for all alias
function all(){
        chmod 777 "$@" && cv;
}

#this alias to reload the zshrx file
alias rld="rld"

#this function for rld alias
function rld(){
  clear;
  source /root/.$(basename $SHELL)rc;
  local saved_file="zshrc[root]"
  cat /root/.zshrc > /home/h471x/NTSOA/zshrc/linux/$saved_file;
  all /home/h471x/NTSOA/zshrc/linux/$saved_file;
  c && br;
  echo "z s h    s a v e d " | figlet -t -c;
  # tlk "saved";
  br && sleep 0.5;
  op /home/h471x/NTSOA/zshrc;
}

#this alias to show the welcome message
alias cvi="cvii"

#here to write a welcome message
function cvii(){
  clear;
  br 2;
  #cat ~/Desktop/logo.txt;
  echo "R   o   o   t" | figlet -t -c;
  br 2;
}

# call the cv alias whenever a wrong
# command is typed which doesn't surely exist
command_not_found_handler() {
  local command=$1
  local command_found=0

  # Check if the command is found in the .zshrc file
  if grep -q -E "^alias $command=" "$HOME/.zshrc" ; then
    command_found=1
  fi

  if [[ $command_found -eq 0 ]]; then
    # c && br && echo "n o t     f o u n d " | figlet -t -c | lolcat;
    # br && sleep 0.5 && cv;
    cv;
  fi
}s

#this alias to view the current directory content with specifications
alias cvg="cvg"

#this function for cv alias
function cvg(){
  tmx && c && br;
  if [[ $# -eq 1 ]]; then
    echo "   $(basename "$PWD") folder content with "$1" : ";
    br && ls | grep "$1" && br;
  elif [[ $# -eq 0 ]]; then
    cv;
  fi
}

#this line to count line and words inside a file
alias flc="flc"

#this function for the cl alias
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
      br;
    else
      grep -c "$1" "$2" | awk -v var="$1" '{print $1, var, "in it"}'
    fi
  elif [[ -d "$1" ]]; then
    dc "$1";
  fi
}


#this alias to open a directory
alias op="op"

#this function for op alias
function op(){
	cd "$1" && cv;
}

#this alias to go back from a directory
alias b="b"

#this function for b alias
function b(){
	if [[ $# -eq 0 ]]; then
		cd .. && cv
	else
		for ((i=1; i<=$1;i++)); do
			cd .. && cv
		done
	fi
}

#this alias to go to the previous directory
alias nd="nd"

#this function for nd alias
function nd(){
        cd - && cv;
}

#here to access the devops folder
alias dvps="op /home/h471x/NTSOA/COURSE/DEVOPS/NOTES"

#this alias to view the aws informations
alias awss="op /home/h471x/NTSOA/COURSE/DEVOPS/AWS "

#this alias to access the eni folder
alias eni="op /home/h471x/NTSOA/COURSE/ENI"

#this alias to go to the desktop
alias dtp="op /home/h471x/Desktop"

#this alias to go to the download folder
alias dwl="op /home/h471x/Downloads"

#this alias to view the history
alias hst="hst"

#this function for hst alias
function hst(){
        if [[ $# -eq 0 ]]; then
                history | less && cv
        else
                #if [[ $1-0 -eq 0 ]]; then #check if the argument is an inte>
                        history | tail -$1 | less && cv
                #else #else, it's a text to grep
                #       history | grep "$1" | less && cv
                #fi
        fi
}

#this alias to specify which command in the history to search
alias hsg="hsg"

#this function for hsg alias
function hsg(){
        if [[ $# -eq 0 ]]; then
                history | less && cv;
        else
                history | grep "$1" | less && cv;
        fi
}

#this alia to update the package
alias upd="upd"

#this function for up alias
function upd(){
        c &&  echo -e && echo -e && echo "       u p d a t i n g .  .  . " | figlet | lolcat && echo -e && apt update && echo -e;
}

#this alia to update the package
alias upg="upg"

#this function for up alias
function upg(){
        c && echo -e && echo -e && sudo clear && echo -e && echo -e && echo "u p g r a d i n g . . ." | figlet | lolcat && echo -e && apt upgrade && echo -e;
}


#this alias to install package
alias ist="ist"

#this function for ist alias
function ist(){
        c && echo -e && echo -e && echo "     i n s t a l l i n g .  .  . " | figlet -t -c | lolcat && echo -e && echo "Package =======> "$1" " && echo -e && apt install "$1" && echo -e;
}

#this alias to install package
alias rmv="rmv"

#this function for ist alias
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

#this alias to view inside a file
alias vf="vf"

#this function for vf alias
function vf(){
	if [[ $# -eq 2 ]]; then
		cat "$1" | grep "$2" | less && cv;
	elif [[ $# -eq 1 ]]; then
    nvim "$1";
	fi
}

#this alias to rename a file
alias nm='function nm(){mv "$1" "$2" && cv};nm'

#this alias to view tthe manual entry for a command
alias mn="mn"

#this function for mn alias
function mn(){
        man "$1" && cv;
}

#this alias to enter the manual directory
alias mnv="mnv"

#this function for mnv alias
function mnv(){
  if [[ $# -eq 0 ]]; then
    op /home/h471x/NTSOA/manual;
  elif [[ $# -eq 1 ]]; then
    op /home/h471x/NTSOA/manual "$1";
  fi
}

#this alias to edit a file
alias ed="ed"

#this function for ed alias
function ed(){
  nvim -c "startinsert" "$1" && cv;
}

#this alias to open the current directory inside neovim
alias nvm="nvm"

# this function for nvm aliases
function nvm(){
  if [[ ! -e "$1" ]]; then
    touch "$1"
  fi
  local file="$1"
  nvim "${file:-.}";
  cv;
  # if we have one argument then nvim will be launched with it,
  # if the file doesn't exist we create just like nano do
  # otherwise open the current directory if there is no argument
}

#this alias to create a file
alias tf="tf"

#this function for tf alias
function tf(){
        sudo -u h471x touch "$@" && sudo -u h471x chmod 777 "$@" && cv;
}

#this alias to delete file
alias dlf="dlf"

#this function for dlf alias
function dlf(){
        rm "$@" && cv;
}

#this line to have destination location for copy / cut
alias dt="dt"

#this function for dst alias
function dt(){
	dest="$PWD" && c && echo -e && echo "            d e s t     s a v e d" | figlet | lolcat && sleep 0.5 && cv;
}

#this alias to open a directory and make it as destination
alias opd="opd"

#this function for opd alias
function opd(){
	op "$1" && dt && nd;
}

#this alias to copy a file then display it
alias cpf="cpf"

#this function for cpf alias
function cpf(){
	if [[ $# -eq 2 ]]; then
        	cp "$1" "$2" && op "$2";
	elif [[ $# -eq 1 ]]; then
		cp $1 $dest && op $dest
	fi
}

#this alias to copy a file then display it
alias mvf="mvf"

#this function for cpf alias
function mvf(){
        if [[ $# -eq 2 ]]; then
                mv "$1" "$2" && op "$2";
        elif [[ $# -eq 1 ]]; then
                mv $1 $dest && op $dest #&& sleep 1 && nd;
        fi
}

#this alias to create a directory
alias drc="drc"

#this function for dr alias
function drc(){
        mkdir "$@" && cv;
}

#this alias to remove a directory
alias rd="rd"

#this function for rd alias
function rd(){
        rm -r "$@" && cv;
}

#this alias to force delete
alias rdf="rdf"

#this function for rdf alias
function rdf(){
  clear && rm -rf "$@" && cv;
}
#this alias to create a directory 
#and then directly enter to it
alias opdr="opdr"

#this function for opdr alias
function opdr(){
  drc "$1" && op "$1";
}


#this alias to view the usb device connected here
alias usb="op /media/h471x"

#this alias to view the pc state
alias pc="c && echo -e && echo -e && sudo -u h471x neofetch --source /home/h471x/.config/neofetch/hn.txt"

#this alias to go to home directory
alias hm="op /root && cv"

#this alias to go to NTSOA directory
alias hn="op /home/h471x/NTSOA"

#here to clear at startup
# clear && echo -e && echo    " $(basename "$PWD") folder content : " && echo -e && ls && echo -e
# cv

#here to view the ssh status
alias sth="sth"

#this function for sth alias
function sth(){
  if [[ $(pgrep sshd) ]]; then
    c && br && echo " ssh server is active" && br;

    local eth_ip=$(ifconfig eth0 | grep "inet " | awk '{print $2}');

    if [ -d /sys/class/net/wlan0 ]; then
      local wlan_ip=$(ifconfig wlan0 | grep "inet " | awk '{print $2}');
      echo " eth0  Connection ==> ssh $USER@$eth_ip";
      echo " wlan0 Connection ==> ssh $USER@$wlan_ip";
      br;
    else
      echo " eth0  Connection ==> ssh $USER@$eth_ip" && br;
    fi
  else
    c && br && echo " ssh server is off" && br;
  fi
}

#this alias to show the network configuration
alias ipsh="ipsh"

#this function for ntsh alias
function ipsh(){
        c && echo -e && echo "      Network informations : " && echo -e && ifconfig && echo -e;
}

#this alias to show the network configuration
alias ntsh="ntsh"

#this function for ntsh alias
function ntsh(){
        c && echo -e && echo "      Network informations : " && echo -e && iwconfig wlan0 && echo -e;
}

#this alias to define the type of the wireless adapter
alias wtp="wtp"

#this function for wtp alias
function wtp(){
  if [[ $# -eq 2 ]]; then
    ip link set "$1" down;
    iw "$1" set type "$2";
    ip link set "$1" up;
  else
    c && br 2;
    echo "Invalid Argument" | figlet -t -c;
    br;
  fi
}

#this alias to scan wifi
alias scn="scn"

#this function for scn alias
function scn(){
  c && br 2 && sudo clear;
  wtp wlan0 monitor;
  br 2;
  echo "s c a n n  i n g . . ." | figlet -t -c | lolcat;
  sleep 1;
  airodump-ng wlan0;
  wtp wlan0 managed;
  br;
}


#this alias to switch to monitor mode
alias mntr="mntr"

#this function for mntr alias
function mntr(){
        c && echo -e && echo -e && sudo clear && sudo ip link set wlan0 down && sudo iw wlan0 set type monitor && sudo ip link set wlan0 up && echo -e && echo -e && echo "                             M o n i t o r" | figlet | lolcat && sleep 0.5 && ntsh;
}

#this alias to switch to managed mode
alias mngd="mngd"

#this function for mngd alias
function mngd(){
        c && echo -e && echo -e && sudo clear && sudo ip link set wlan0 down && sudo iw wlan0 set type managed && sudo ip link set wlan0 up && echo -e && echo -e && echo "                        M a n a g e d" | figlet | lolcat && sleep 0.5 && ntsh;
}


#this alias to run wifite
alias whk="whk"

#this function for whk alias
function whk(){
        c && wifite;
}

#this alias to enable the ssh server
alias sshon="sshon"

#this function for sshon alias
function sshon(){
  clear && br 2 && sudo clear;
  systemctl start ssh;
  sth;
}

#this alias to kill the ssh server
alias sshoff="sshoff"

#this alias for sshoff alias
function sshoff(){
  clear && br 2 && sudo clear;
  # sudo kill $(sudo lsof -t -i:22);
  # or use this in termux
  kill $(pgrep sshd)
  sth;
}

#this alias to view the irc sever status
alias irth="irth"

#this function for irth alias
function irth(){
  c && br 2;
  echo "    irc server status : ";
  br;
  service inspircd status ;
  br;
}

#this alias to start the irc server
alias ircon="ircon"

#this function for ircon alias
function ircon(){
  clear;
  service inspircd start;
  irth;
}

#this alias to restart the irc server
alias ircrst="ircrst"

#this function for ircrst alias
function ircrst(){
  clear;
  service inspircd restart;
  irth;
}


#this alias to stop the irc server
alias ircoff="ircoff"

#this function for ircoff alias
function ircoff(){
  clear;
  service inspircd stop;
  irth;
}

#snmpd


#this alias to show the network configuration
alias ntsh="ntsh"