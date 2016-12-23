#!/usr/bin/env bash

# Props to : https://github.com/driesvints

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Switch to using brew-installed ZSH as default shell and install oh-my-zsh
if ! fgrep -q $(which zsh) /etc/shells; then
  echo $(which zsh) | sudo tee -a /etc/shells;
  # Install oh-my-zsh
  curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | zsh;
  # Link to .zshrc and .aliases
  ln -sf $(pwd)/.aliases ~/;
  ln -sf $(pwd)/.zshrc ~/;
  # chsh -s $(which zsh)
fi;

# Configure Vim
if test ! -e ~/.vim/autoload/plug.vim; then
  # Install Vim plugin manager (vim-plug).
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
  # Link to .vimrc
  ln -sf $(pwd)/.vimrc ~/;
  # Install Vim Plugins
  vim +PlugInstall +qall;
fi

# Set macOS preferences
# We will run this last because this will reload the shell
# source .macos
