#!/bin/bash

# vim settings
ln -sfn `pwd`/.vimrc ~/.vimrc
vim -c PlugInstall -c q -c q

# tmux settings
ln -sfn `pwd`/.tmux.conf ~/.tmux.conf

# alias settings
ln -sfn `pwd`/.alias ~/.bashrc.kangmin
echo "source ~/.bashrc.kangmin" >> ~/.bashrc

# zsh settings
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
echo "ZSH_THEME=pygmalion" >> ~/.oh-my-zsh/custom/example.zsh
ln -sfn `pwd`/.alias ~/.oh-my-zsh/custom/alias.zsh

