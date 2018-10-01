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

alias cd=cd_desktop
alias rm=trash
alias undo=undo_trash


function update_bash_profile() {
	current=$(date -r .bash_profile +%s)
	latest=$(cat profile-repo/time)

	if [ $current -le $latest ]
	then
		return 0
	fi

	echo "$current" > profile-repo/time
	cp .bash_profile profile-repo/.bash_profile
	cd profile-repo
	git add .
	git commit -m "Updated: $current"
	git push origin master
	cd $OLDPWD
}

update_bash_profile


