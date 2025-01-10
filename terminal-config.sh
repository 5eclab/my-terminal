#!/bin/bash

# Verifique se o script está sendo executado como root para instalar pacotes
if [[ $EUID -ne 0 ]]; then
   echo "Aviso: Você não é root. Os pacotes não serão instalados. Continuando apenas com a configuração do terminal."
   INSTALL_PACKAGES=false
else
   INSTALL_PACKAGES=true
fi

# Instale pacotes se for root
if [[ $INSTALL_PACKAGES == true ]]; then
   echo "Instalando pacotes necessários..."
   sudo apt update
   sudo apt install -y zsh curl wget git
fi

# Instale o Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
   echo "Instalando o Oh My Zsh..."
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
   echo "Oh My Zsh já está instalado."
fi

# Configure o Zsh como shell padrão
if [[ "$(echo $SHELL)" != "$(which zsh)" ]]; then
   echo "Configurando o Zsh como shell padrão..."
   chsh -s $(which zsh)
else
   echo "Zsh já é o shell padrão."
fi

# Baixe o tema personalizado
echo "Baixando o tema af-magic-custom.zsh-theme..."
wget -O ~/.oh-my-zsh/themes/af-magic-custom.zsh-theme https://raw.githubusercontent.com/5eclab/my-terminal/main/af-magic-custom.zsh-theme

# Configure plugins do Zsh
echo "Instalando plugins do Zsh..."
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# Autosuggestions
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
   git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
else
   echo "Plugin zsh-autosuggestions já instalado."
fi

# Syntax Highlighting
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
else
   echo "Plugin zsh-syntax-highlighting já instalado."
fi

# Autocomplete
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autocomplete" ]]; then
   git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
else
   echo "Plugin zsh-autocomplete já instalado."
fi

# Baixe o arquivo .zshrc personalizado
echo "Baixando o arquivo .zshrc personalizado..."
wget -O ~/.zshrc https://raw.githubusercontent.com/5eclab/my-terminal/main/.zshrc

exec zsh
