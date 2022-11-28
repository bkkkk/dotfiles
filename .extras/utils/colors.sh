black=`tput setaf 0`
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`

bg_black=`tput setab 0`
bg_red=`tput setab 1`
bg_green=`tput setab 2`
bg_yellow=`tput setab 3`
bg_blue=`tput setab 4`
bg_magenta=`tput setab 5`
bg_cyan=`tput setab 6`
bg_white=`tput setab 7`

bold=`tput bold`
dim=`tput dim`

reset=`tput setaf sgr0`

tick="\u2714"
cross="\u2716"
star="\u2605"
bullet="\u2022"


function log_h1() {
    echo "${white}${bold}${1}${reset}"
}

function log_info() {
    echo "${blue}${bold}${bullet} ${1}${reset}"
}

function log_success() {
    echo "${green}${bold}${tick} ${1}${reset}"
}


function error_exit() {
     echo "${red}${bold}${cross} ${1}${reset}" 1>&2
     exit 1
}

function wait_on_error() {
     read -q "REPLY?${yellow}${bold}${question} ${1} Should we continue? [Y]es.${reset}"
     if [ "$REPLY" = "Y" ]; then
          return
     else
          exit 1
     fi
}
