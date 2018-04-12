#!/bin/bash
# user configurations
shell=fish


# find OS

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
esac

# vim settings
ln -sfn `pwd`/vim/.vimrc ~/.vimrc
vim -c PlugInstall -c q -c q

# tmux settings
ln -sfn `pwd`/tmux/.tmux.conf ~/.tmux.conf

if [ "$shell" = "bash" ]
then
    # alias settings
    ln -sfn `pwd`/.alias ~/.bashrc.kangmin
    echo "source ~/.bashrc.kangmin" >> ~/.bashrc

elif [ "$shell" = "zsh" ]
then
    # zsh settings
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    echo "ZSH_THEME=pygmalion" >> ~/.oh-my-zsh/custom/example.zsh
    ln -sfn `pwd`/.alias ~/.oh-my-zsh/custom/alias.zsh
    chsh -s "`which zsh`"

elif [ "$shell" = "fish" ]
then
    # fish shell settings
	if [ "$machine" == "Mac" ]
	then
	    brew install fish
	else
		sudo add-apt-repository ppa:fish-shell/release-2
		sudo apt-get update
		sudo apt-get -y install fish ctags
	fi
    curl -L https://get.oh-my.fish | fish
    ln -sfn `pwd`/fish/fish_prompt.fish  ~/.local/share/omf/themes/default/fish_prompt.fish
    ln -sfn `pwd`/fish/key_bindings.fish ~/.config/omf/key_bindings.fish
    ln -sfn `pwd`/fish/init.fish ~/.config/omf/init.fish

    PATH_FISH=`which fish`
    sudo bash -c 'echo "$1" >> /etc/shells' _ $PATH_FISH
    chsh -s "$PATH_FISH"
	if [ "$machine" == "Mac" ]
	then
	    fish -c "set -Ux LSCOLORS gxfxbEaEBxxEhEhBaDaCa"
	else
		./dircolors
	fi
    fish -c "omf reload"
fi
