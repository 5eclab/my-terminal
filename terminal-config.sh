#!/bin/bash

# Verifique se o script está sendo executado como root para instalar pacotes
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root para instalar pacotes." 
   exit 1
fi

# Instale o Zsh
echo "Instalando o Zsh..."
sudo apt update
sudo apt install -y zsh curl wget git

# Instale o Oh My Zsh
echo "Instalando o Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Configure o Zsh como shell padrão
echo "Configurando o Zsh como shell padrão..."
chsh -s $(which zsh)

# Baixe o tema personalizado
echo "Baixando o tema af-magic-custom.zsh-theme..."
wget -O ~/.oh-my-zsh/themes/af-magic-custom.zsh-theme https://raw.githubusercontent.com/5eclab/my-terminal/main/af-magic-custom.zsh-theme

# Instale plugins para o Zsh
echo "Instalando plugins do Zsh..."
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

# Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# Fast Syntax Highlighting (redundante com o zsh-syntax-highlighting, escolha um)
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting

# Autocomplete
git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

# Baixe o arquivo .zshrc personalizado
echo "Baixando o arquivo .zshrc personalizado..."
wget -O ~/.zshrc https://raw.githubusercontent.com/5eclab/my-terminal/main/.zshrc

# Atualize as permissões e recarregue o Zsh
echo "Finalizando configuração..."
sudo chmod -R 755 ~/.oh-my-zsh
exec zsh
