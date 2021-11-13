#!/bin/zsh

source utils/colors.sh

error_exit() {
     echo "${red}${bold}${cross} ${1}${reset}" 1>&2
     exit 1
}

wait_on_error() {
     read -q "REPLY?${yellow}${bold}${question} ${1} Should we continue? [Y]es.${reset}"
     if [ "$REPLY" = "Y" ]; then
          return
     else
          exit 1
     fi
}

echo "${white}${bold}== Welcome! Setting up standard Jacob environment ==${reset}"


echo "${blue}${bold}${bullet} Installing Command Line Tools${reset}"
xcode-select --install
echo "${green}${bold}${tick} Command-line tools have been installed${reset}"


echo "${blue}${bold}${bullet} Installing Homebrew${reset}"
if ! which brew > /dev/null; then
     # Install Homebrew 
     /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;
echo "${green}${bold}${tick} Homebrew has been installed${reset}"


echo "${blue}${bold}${bullet} Installing applications in Brewfile${reset}"
brew update & brew bundle || wait_on_error "Failed to install some Homebrew applications."
echo "${green}${bold}${tick} Homebrew applications have been installed${reset}"


echo "${blue}${bold}${bullet} Setting up Shell Config${reset}"
./zsh/install.sh || error_exit "Failed to configure ZSH"
echo "${green}${bold}${tick} ZSH config has been updated${reset}"


echo "${blue}${bold}${bullet} Setting up Python3${reset}"
./python/install.sh || error_exit "Failed to setup Python3 environment"
echo "${green}${bold}${tick} Python3 environment has been setup${reset}"


echo "${blue}${bold}${bullet} Setting up Applications${reset}"
./app_configs/install.sh || error_exit "Failed to configure applications"
echo "${green}${bold}${tick} Additional application configuration has been set${reset}"


echo "${blue}${bold}${bullet} Setting up MacOS defaults configuration${reset}"
./.macos || error_exit "Failed to setup some MacOS configuration"
echo "${green}${bold}${tick} MacOS configuration is finished${reset}"


echo "${white}${bold}${star} All Done!${reset}"
