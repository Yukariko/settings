#!/bin/bash

# vim settings
ln -sfn `pwd`/vim/.vimrc ~/.vimrc
vim -c PlugInstall -c q -c q

# tmux settings
ln -sfn `pwd`/tmux/.tmux.conf ~/.tmux.conf

# alias settings
ln -sfn `pwd`/.alias ~/.bashrc.kangmin
echo "source ~/.bashrc.kangmin" >> ~/.bashrc

# zsh settings
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
echo "ZSH_THEME=pygmalion" >> ~/.oh-my-zsh/custom/example.zsh
ln -sfn `pwd`/.alias ~/.oh-my-zsh/custom/alias.zsh

# fish shell settings
brew install fish
curl -L https://get.oh-my.fish | fish
ln -sfn `pwd`/fish/fish_prompt.fish  ~/.local/share/omf/themes/default/fish_prompt.fish
ln -sfn `pwd`/fish/key_bindings.fish ~/.config/omf/key_bindings.fish
ln -sfn `pwd`/fish/init.fish ~/.config/omf/init.fish
omf reload
