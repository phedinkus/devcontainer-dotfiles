#!/bin/sh

install_zsh() {
  if ! command -v zsh >/dev/null 2>&1; then
    echo "zsh is not installed. Please install zsh and rerun this script."
    exit 1
  fi

  # Get the path of zsh
  ZSH_PATH=$(which zsh)

  PLUGINS_DIR="$HOME/.zsh_addons"
  # Get the directory of the script
  SCRIPT_DIR=$(dirname "$(realpath "$0")")
  # copies dotfiles

  # Creates root directories if they don't exist
  mkdir -p "$HOME/.config"
  mkdir -p "$PLUGINS_DIR"

  # Create symlinks for the dotfiles
  ln -s "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"

  # Create a symlink for the starship configuration
  git clone https://github.com/zsh-users/zsh-autosuggestions $PLUGINS_DIR/zsh-autosuggestions
  git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $PLUGINS_DIR/zsh-autocomplete
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $PLUGINS_DIR/fast-syntax-highlighting

  # Change the default shell to zsh
  sudo chsh -s "$ZSH_PATH"

  # Check if the shell was changed successfully
  if [ $? -eq 0 ]; then
    echo "Successfully changed the default shell to zsh."
    echo "Please log out and log back in for the changes to take effect."
  else
    echo "Failed to change the default shell."
    exit 1
  fi
}


main() {
  install_zsh
}

main