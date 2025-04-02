# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

set autocd #change directory just by typing his name
setopt promptsubst #enable command substitution in prompt

fastfile_var_prefix='$'

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# CHROME_PATH=/mnt/c/Program\ Files/Google/chrome/Application/
# Add clip.exe to Path
SYSTEM32_PATH="/mnt/c/Windows/System32"
NEOVIM_PATH="/opt/nvim/bin"

PATH="$PATH:$NEOVIN_PATH:$SYSTEM32_PATH"

# this to make Github CLI know which default browser it would use
# this WSL issue was solved in gh GitHub Repo Pull Request
# export BROWSER="chrome.exe"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Declare the variable for zsh-syntax-highlighting styles
typeset -A ZSH_HIGHLIGHT_STYLES

# I found those from ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/highlighters/main/README.md
# ZSH_HIGHLIGHT_STYLES[path]='fg=#3B78FF,bold'
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

# Add wisely, as too many plugins slow down shell startup.
plugins=(fastfile copyfile vscode extract docker zsh-autosuggestions git nmap terraform sudo themes encode64 python)

# Here to disable oh-my-zsh auto update
DISABLE_AUTO_UPDATE="true"

source $ZSH/oh-my-zsh.sh

#this alias to clear
alias c="clear"

#this alias to clear but with extra lines
alias x="clear && echo -e && echo -e && echo -e && echo -e && echo -e && echo -e"

#this alias to exit
alias q='q'

#this function is for q alias
function q(){
  exit
}


#this alias to give full permission
alias all="all"

#this function for all alias
function all(){
	if [[ $# -eq 0 ]]; then
		chmod 777 * && cv;
	else
		chmod 777 "$@" && cv;
	fi
}

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

# Enable MOTD message at startup
# Edit it inside /etc/update-motd.d/10-uname
run-parts /etc/update-motd.d

#this alias to break a line
alias br="br"

#this function for br alias
function br(){
  if [[ $# -eq 1 ]]; then
    for ((i=1; i<=$1;i++)); do
      echo -e;
    done
  elif [[ $# -eq 0 ]]; then
    echo -e;
  fi
}

#this alias to show the welcome message
alias cvi="cvii"

#here to write a welcome message
function cvii(){
#	if [[ "$session_open" -eq 0 ]]; then
		#clear && echo -e && echo "H    4    7    1    X" | figlet -t -c && echo -e;
#		session_open=1
		#clear && echo -e && echo -e && echo "H A T I X" | figlet -t -c -f 3d && echo -e && echo -e;
		clear && echo -e && echo -e && echo "H    4    7    1    X" | figlet -t -c && echo -e && echo -e;
#	elif [[ "$session_open" -eq 1 ]]; then
#		clear && echo -e && echo -e && echo "H 4 7 1 X" | figlet -t -c && echo -e && echo -e
#	fi
}

#call the followinf alias at startup
#clear && echo -e && echo -e && echo -e && echo -e && echo -e && echo -e && echo -e && echo -e
#clear && cvi

# this alias to have the current view
# of working directory content using ls
alias cv="cv"

# this function for cv alias
# UPDATED : 01/25/2024
# to adjust the title
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
    eza --icons=always --no-quotes --group-directories-first $folder_content
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
# UPDATED : 01/25/2024
# to adjust the title
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
    eza --icons=always --no-quotes -a --group-directories-first $folder_content;
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

# this alias to view the current directory content
# with specifications
alias cvg="cvg"

# this function for cvg alias
function cvg(){
  local folder_name=$(basename $PWD)
  local item="$1"
  local matched_items=$(ls -A | grep "$item" | wc -l)

  function show_header(){
    echo "${BOLD}   $folder_name -> contains $matched_items '$1' ${RESET}";
  }

  function show_content(){
    eza --icons=always --color=always -a --group-directories-first | grep "$1";
  }

  # this function to show the cv
  function show_all(){
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

#call the cv alias whenever a wrong command is typed which doesn't surely exist
command_not_found_handler() {
  local command=$1
  local command_found=0

  # Check if the command is found in the .zshrc file
  if grep -q -E "^alias $command=" "$HOME/.zshrc" ; then
    command_found=1
  fi

  if [[ $command_found -eq 0 ]]; then
    c && echo -e && echo "n o t     f o u n d " | figlet -t -c | lolcat && echo -e && sleep 0.5 && cv;
  fi
}


#press the button alt twice to call cv
#zle -N cv
#bindkey ^²' cv

#this alias to view the current directory content with specifications
alias cvg="cvg"

#this function for cv alias
function cvg(){
        tmx && c && echo -e && echo "   $(basename "$PWD") folder content with "$1" : " && echo -e && ls | grep "$1" && echo -e;
}


#here to launch tmux and cv after 1 second
#sleep 1 && tmux && cv

#this alias to enter the zshrc file
alias ct="nvim /root/.zshrc && cv"

#this alias to open a directory
alias op="op"

#this function for op alias
function op(){
	if [[ -d "$1" ]]; then
		if [[ $# -eq 1 ]]; then
			cd "$1" && cv;
		elif [[ $# -eq 2 ]]; then
			cd "$1" && cvg "$2";
		fi
	elif [[ -f "$1" ]]; then
		vf "$1"
	fi
}

#this alias to open a directory and make it as destination
alias opd="opd"

#this function for opd alias
function opd(){
        op "$1" && dt && nd;
}

#this alias to create a directory and then directly enter to it
alias opdr="opdr"

#this function for opdr alias
function opdr(){
	dr "$1" && op "$1";
}

#this alias to run executable file
alias rn="rn"

#this function for rn alias
function rn(){
	case "${1##*.}" in
		py)
			c && echo -e && echo -e && sudo clear && sudo python3 "$1"
			;;
		c)
			#if [ -f "${1%.*}" ]; then #check if the executable does exist
			#	dlf "${1%.*}" && gcc "$1" -o "${1%.*}" && all "${1%.*}" && clear && ./"${1%.*}"
			#else #if the executable does not exist
			#	gcc "$1" -o "${1%.*}" && all "${1%.*}" && clear && ./"${1%.*}"
			#fi
			#file="$1"
			#library_name=""

			# Extract the library name from the C file
			#library_name=$(grep -oP '#include <(\K[^>]+)' "$file" | cut -d'/' -f1)

			#if [[ "$library_name" == "math" ]]; then
  				# Compile the C file with the math library flag
  			#	if [ -f "${file%.*}" ]; then
    			#		# Check if the executable exists
    			#		dlf "${file%.*}" && gcc "$file" -o "${file%.*}" -lm && all "${file%.*}" && clear && ./"${file%.*}"
  			#	else
    					# If the executable does not exist
    			#		gcc "$file" -o "${file%.*}" -lm && all "${file%.*}" && clear && ./"${file%.*}"
  			#	fi
			#else
  				# Compile the C file without the math library flag
  			#	if [ -f "${file%.*}" ]; then
    					# Check if the executable exists
    			#		dlf "${file%.*}" && gcc "$file" -o "${file%.*}" && all "${file%.*}" && clear && ./"${file%.*}"
  			#	else
    					# If the executable does not exist
    			#		gcc "$file" -o "${file%.*}" && all "${file%.*}" && clear && ./"${file%.*}"
  			#	fi
			#fi

			file="$1"
			library_found="0"

			# Check if the <math.h> library is included in the C file
			if grep -E '^#include <math.h>' "$file" >/dev/null; then
  				library_found="1"
			fi

			if [[ "$library_found" == "1" ]]; then
  				# Compile the C file with the math library flag
  				if [ -f "${file%.*}" ]; then
    					# Check if the executable exists
    					dlf "${file%.*}" && gcc "$file" -o "${file%.*}" -lm && all "${file%.*}" && clear && ./"${file%.*}"
  				else
    					# If the executable does not exist
    					gcc "$file" -o "${file%.*}" -lm && all "${file%.*}" && clear && ./"${file%.*}"
  				fi
			else
  				# Compile the C file without the math library flag
  				if [ -f "${file%.*}" ]; then
    					# Check if the executable exists
    					dlf "${file%.*}" && gcc "$file" -o "${file%.*}" && all "${file%.*}" && clear && ./"${file%.*}"
  				else
    					# If the executable does not exist
    					gcc "$file" -o "${file%.*}" && all "${file%.*}" && clear && ./"${file%.*}"
  				fi
			fi
			;;
		cpp)
			if [ -f "${1%.*}" ]; then #check if the executable does exist
                                dlf "${1%.*}" && g++ "$1" -o "${1%.*}" && all "${1%.*}" && clear && ./"${1%.*}"
                        else #if the executable does not exist
                                g++ "$1" -o "${1%.*}" && all "${1%.*}" && clear && ./"${1%.*}"
                        fi
                        ;;
		html)
			google-chrome "$1" && cv
			;;
		php)
			php -S 127.0.0.1:8080 | google-chrome 127.0.0.1:8080/"$1" && cv
			;;
		*)
			c && echo -e && echo -e && sudo clear && sudo ./"$1"
			;;
	esac

}

#this alia to update the package
alias upd="upd"

#this function for up alias
function upd(){
	c && echo -e && echo -e && sudo clear && echo -e && echo -e && echo "     u p d a t i n g .  .  ." | figlet | lolcat && echo -e && sudo apt update && echo -e;
}

#this alia to update the package
alias upg="upg"

#this function for up alias
function upg(){
        c && echo -e && echo -e && sudo clear && echo -e && echo -e && echo "u p g r a d i n g . . ." | figlet | lolcat && echo -e && sudo apt upgrade && echo -e;
}

#this alias to install package
alias ist="ist"

#this function for ist alias
function ist(){
	#if [[ -d "$1" ]]; then
	#	clear && echo -e && echo -e && echo "   C l o n i n g .  .  . " | figlet | lolcat && echo -e && echo "Package =======> "${1%.*}" " && echo -e && git clone "$1" && op "$1";
	#else
		case "${1##*.}" in
			git)
				clear && echo -e && echo -e && echo "   C l o n i n g .  .  . " | figlet | lolcat && echo -e && echo "Package =======> "${1%.*}" " && echo -e && git clone "$1" && echo -e;
				;;
			deb)
				c && echo -e && echo -e && sudo clear && echo -e && echo -e && echo "   I n s t a l l i n g .  .  . " | figlet | lolcat && echo -e && echo "Package =======> "${1%.*}" " && echo -e && sudo dpkg -i "$1" && echo -e;
				;;
			*)
				c && echo -e && echo -e && sudo clear && echo -e && echo -e && echo "   I n s t a l l i n g .  .  . " | figlet | lolcat && echo -e && echo "Package =======> "$1" " && echo -e && sudo apt install "$1" && echo -e;
				;;
		esac
	#fi
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

#this alias to connect to a ssh server
alias cns="cns"

#this function for cns alias
function cns(){
	if [[ $# -eq 0 ]]; then
		c && echo -e && echo -e && sudo clear && echo -e && echo -e && echo "s s h    l o g i n" | figlet -t -c | lolcat && echo -e && echo -ne " User : " && read user && echo -ne " IP adress : 192.168." && read ip1 && clear && echo -e && echo -e && echo "s s h    l o g i n" | figlet -t -c | lolcat && echo -e && echo " User : "$user"" && echo -ne " IP Adress : 192.168."$ip1"."&& read ip2 && echo -e && echo " Connection to <"$user"> 's ssh server at <192.168."$ip1"."$ip2"> adress !! " && echo -e && ssh $user@192.168.$ip1.$ip2 && echo -e;
	elif [[ $1 -eq '-a' ]]; then
		c && echo -e && echo -e && sudo clear && echo -e && echo -e && echo "s s h    l o g i n" | figlet -t -c | lolcat && echo -e && echo -ne " User : " && read user && echo -ne " IP adress : 192.168." && read ip && echo " Port : 8022" && echo -e && echo " Connection to <"$user"> 's ssh server at <192.168."$ip"> adress !! " && echo -e && ssh $user@192.168.$ip -p 8022 && echo -e;
	elif [[ $1 -eq '-i' ]]; then
		c && echo -e && echo -e && sudo clear && echo -e && echo -e && echo "s s h    l o g i n" | figlet -t -c | lolcat && echo -e && echo -ne " User : " && read user && echo -ne " IP adress : " && read ip3 && echo -e && echo " Connection to <"$user"> 's ssh server at <"$ip3"> adress !! " && echo -e && ssh $user@$ip3 && echo -e;
	fi
}

#this alias to view inside a file
alias vf="vf"

#this function for vf alias
function vf(){
	#if [[ $# -eq 0 ]]; then
	#	cv;
	#elif [[ $# -eq 1 ]]; then
	#	cat "$1" | less && cv;
	#elif [[ $# -eq 2 ]]; then
	#	cat "$1" | grep "$2" | less && cv;
	#fi

	#detects if the argument is a file
	if [[ -f "$1" ]]; then
		case "${1##*.}" in
			JPG || jpg || ico || png)
				ristretto "$1" && cv
				;;
			pdf)
				atril "$1" && cv
				;;
			cap)
				wireshark "$1" && cv
				;;
			ods)
				xdg-open "$1" && cv
				;;
			mp*)
				vlc "$1" && cv
				;;
			gz || rar)
				engrampa "$1" && cv
				;;
			html || c || cpp || tf || py || java || js || css || json)
				code "$1" && cv
				;;
			*)
				#same condition but using the case statement
				case "$#" in
					1)
						cat "$1" | less && cv
						;;
					2)
						cat "$1" | grep "$2" | less && cv
						;;
					*)
						cv
						;;
					esac
				;;
		esac
	elif [[ -d "$1" ]]; then
		op "$1";
	fi
}

#this alias to rename a file / directory; and display it after
alias nm="nm"

#this function for cpf alias
function nm(){
        mv "$1" "$2" && cv;
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

#this alias to view tthe manual entry for a command
alias mns="mns"

#this function for mn alias
function mns(){
	if [[ $(command -v "$1") ]]; then #here to check if the command exists
		man "$1" | cat > ~/NTSOA/manual/"$1".txt && all ~/NTSOA/manual/"$1".txt && cd ~/NTSOA/manual && vf ~/NTSOA/manual/"$1".txt && cv;
	else
		c && echo -e && echo "n o t     f o u n d " | figlet -t -c | lolcat && echo -e && sleep 0.5 && cv;
	fi
}

#this line to count line inside a file
alias cl="linecount"

#this function for the cl alias
function linecount() {
    if [ -z "$1" ]; then
        echo "Please provide a filename"
    elif [ -z "$2" ]; then
        wc -l "$1" | awk '{print $1, "lines"}'
    else
        grep -c "$1" "$2" | awk -v var="$1" '{print $1, var, "in it"}'
    fi
};

#this line to view a command manual
alias mn="mn"

#this function for mn alias
function mn(){
        if [[ $# -eq 1 ]]; then
                man $1 | less
        else
                man $1 | grep $2 | less
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

#this function for nvm aliases
function nvm(){
  nvim "${1:-.}";
  cv;
  #if we have one argument then nvim will be launched with it,
  #otherwise open the current directory if there is no argument
}

#this alias is the same as ed but it uses nano instead of nvim
alias edn="edn"

#this function for edn alias
function edn(){
	nvim "$1";
	if [[ -f "$1" ]]; then
		all "$1" && cv;
	else
		cv;
	fi
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

#this alias to go to the to desktop
alias dtp="op /home/h471x/Desktop"

#this alias to create a file
alias tf="tf"

#this function for tf alias
function tf(){
	touch "$@" && all "$@" && cv;
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
	dest="$PWD" && c && echo -e && echo "d e s t   s a v e d" | figlet -t -c | lolcat && sleep 0.6 && cv;
}

#this alias to copy a file then display it
alias cpf="cpf"

#this function for cpf alias
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

function cpf2() {
	cp "${@:1:$#-1}" "${@:$#}";
}

#this alias to copy the content of a file
alias cnf="cnf"

#this function for cnf alias
function cnf(){
	cat "$1" > "$2" && dlf "$1" && all "$2";
}

#this alias to copy a file then display it
alias mvf="mvf"

#this function for cpf alias
function mvf(){
	if [[ $# -eq 2 ]]; then
        	mv "$@" "$2" && op "$2";
	elif [[ $# -eq 1 ]]; then
		mv $@ $dest && op $dest;
	#if there is only one argument, it will move the file / directory to the the variable dest defined in dt alias
	fi
}

#this alias to create a directory
alias dr="dr"

#this function for dr alias
function dr(){
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

#this alias to view the pc state
alias pc="c && echo -e && echo -e && neofetch"

#call this pc alias at startup
#pc

#this alias to go to home directory
alias hm="cd /root && cv"

#this alias to enter the NTSOA directory
alias hn="op ~/NTSOA"

#this alias to view the history
alias hst="hst"

#this function for hst alias
function hst(){
        if [[ $# -eq 0 ]]; then
                history | less && cv
        else
		re='^[0-9]+$'
		if [[ $1 =~ $re ]]; then #check if the argument is an integrer
               		history | tail -$1 | less && cv
		else  #else if it's a text to grep
			history | grep "$1" | less && cv
		fi
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

#here to view the ssh status
alias sth="sth"

#this function for sth alias
function sth(){
        c && echo -e && echo -e && sudo clear &&  echo -e && echo "    ssh server status : " && echo -e && sudo systemctl status ssh && echo -e;
}

#this alias to show the network configuration
alias ipsh="ipsh"

#this function for ntsh alias
function ipsh(){
        c && echo -e && echo "      Network informations : " && echo -e && ifconfig wlan0 && echo -e;
}

#this alias to enable the ssh server
alias sshon="sshon"

#this function for sshon alias
function sshon(){
	clear && echo -e && echo -e && sudo clear && sudo systemctl start ssh && sth && echo -e && echo "      ssh server IP Adress : " && echo -e && ifconfig wlan0 | grep "inet 192.168"&& echo -e;
}

#this alias to kill the ssh server process
alias sshoff="sshoff"

#this function for sshoff alias
function sshoff(){
	clear && echo -e && echo -e && sudo clear && sudo kill $(sudo lsof -t -i:22) && sth;
}

#session_open, variable to check if there is already a terminal session
#session_open=0

kill-line() {
  if [[ $BUFFER == "" ]]; then
    zle backward-kill-line
  else
    zle kill-whole-line
  fi
}

# call the cv alias whenever a wrong command is typed
# which doesn't surely exist
command_not_found_handler() {
  local command=$1
  local command_found=0

  # Check if the command is found in the .zshrc file
  if grep -q -E "^alias $command=" "$HOME/.zshrc" ; then
    command_found=1
  fi

  if [[ $command_found -eq 0 ]]; then
    # c && br;
    # echo "n o t     f o u n d " | figlet -t -c | lolcat;
    # br && sleep 0.5 && cv;
    cv;
  fi
}

zle -N kill-line
bindkey "²²" kill-line

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
