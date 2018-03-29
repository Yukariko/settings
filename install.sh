#!/bin/bash

# vim settings
ln -s .vimrc ~/.vimrc

# tmux settings
ln -s .tmux.conf ~/.tmux.conf

# alias settings
ln -s .alias ~/.bashrc.kangmin
echo "source ~/.bashrc.kangmin" >> ~/.bashrc
