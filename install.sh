#!/bin/bash - 
#===============================================================================
#
#          FILE: install.sh
# 
#         USAGE: ./install.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 14/09/16 11:22
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
ZSH="False"
while getopts "z:" OPTION
do
    case $OPTION in
        z)
          ZSH="True"
          ;;
    esac
done
python -mplatform | grep -iq Ubuntu && PLATFORM="ubuntu" || PLATFORM="mac"

# Configure basic working environment
if [[ $PLATFORM == "ubuntu" ]]
then
    apt-get install -y git
    apt-get -y install libblas-dev
    apt-get -y install python-numpy python-scipy
    apt-get -y install python-dev python-nose g++ libopenblas-dev
    apt-get -y install tmux
    if [[ ZSH == "True" ]]
    then
        apt-get install zsh
    fi

else
    which -s brew
    if [[ $? != 0 ]]
    then
        # install Homebrew
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    brew install git
    brew install tmux
    if [[ ZSH == "True" ]]
    then
        brew install zsh zsh-completions
    fi
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)
pip install cython
pip install smart-open

#git clone https://github.com/jhlau/gensim.git
