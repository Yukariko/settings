#!/bin/bash

# vim settings
ln -sfn `pwd`/.vimrc ~/.vimrc

# tmux settings
ln -sfn `pwd`/.tmux.conf ~/.tmux.conf

# alias settings
ln -sfn `pwd`/.alias ~/.bashrc.kangmin
echo "source ~/.bashrc.kangmin" >> ~/.bashrc
