#!/usr/bin/env bash

gum_installation () {

  gum format "🎉Welcome into this installation script for squid🐙"
  gum spin --spinner='meter' --spinner.foreground="333" --title "Installing squid🐙..." --show-output -- sudo apt install -y squid-openssl

}

install_gum () {

  sudo mkdir -p /etc/apt/keyrings
  curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
  echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
  sudo apt update && sudo apt install gum -y

  }

simple_installation () {

  echo "Installing squid ..."
  sudo apt install squid-openssl &>/dev/null

}

sudo -v
if  gum --help &>/dev/null ; then
  gum_installation
else
  echo "Gum is not installed!"
  read -rp "Would you like to install it? [y/N]" gum_confirm

  if [[ $"gum_confirm" = ^[Yy]$ ]]; then
    install_gum &>/dev/null
    if gum --help &>/dev/null; then
      gum_installation
    else
      echo "Erro during gum installation!"
      simple_installation
    fi
  else
    simple_installation
  fi

fi



