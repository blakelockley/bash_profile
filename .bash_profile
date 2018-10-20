#!/bin/bash

export PATH=~/flutter/bin:$PATH
export PATH="$HOME/.fastlane/bin:$PATH"
export PATH="/anaconda3/bin:$PATH"

export PYTHONDONTWRITEBYTECODE=0

function cd_desktop() {
	DIR=$1
	if [[ $1 == ~/Desktop || $1 == ! ]]; then 
		DIR=~/.Desktop
	fi
	\cd $DIR
	unlink ~/Desktop
	ln -s `pwd` ~/Desktop
	killAll Finder  
}

function trash() {
	mv $1 ~/.Trash
}

function undo_trash() {
	mv ~/.Trash/$1 .
}

#alias cd=cd_desktop
alias rm=trash
alias undo=undo_trash

function update_bash_profile() {
	current=$(date -r ~/.bash_profile +%s)
	latest=$(date -r  ~/profile-repo/.bash_profile +%s)

	if [ $current -le $latest ]
	then
		return 0
	fi

	echo "Updating remote .bash_profile repo..."

	cp ~/.bash_profile ~/profile-repo/
	cd ~/profile-repo
	git add . 
	git commit -m "Updated: $current" > /dev/null 2>&1
	git push origin master > /dev/null 2>&1
	cd $OLDPWD
}

update_bash_profile

# The half sized up and down keys are most likely the worst design decision ive ever seen on a laptop keyboard and is extremely annoying. This scrip will remap the right shift to up and the half sized up arrow to down - this will give the feel of a correctly designed keyboard.. atleast to an extent.

# remap:
# up arrow 0x52 -> down 0x51
# right shift 0xE5 -> up 0x52

# https://developer.apple.com/library/archive/technotes/tn2450/_index.html

hidutil property --set '{"UserKeyMapping":
     [{"HIDKeyboardModifierMappingSrc":0x7000000e5,
      "HIDKeyboardModifierMappingDst":0x700000052}]
}' > /dev/null

echo "'right shift' key has been rempapped to up arrow"

#    {"HIDKeyboardModifierMappingSrc":0x700000052,
#      "HIDKeyboardModifierMappingDst":0x700000051},

