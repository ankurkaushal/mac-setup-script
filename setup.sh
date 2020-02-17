echo "Creating SSH Key..."
ssh-keygen -t rsa

echo "Please add this public key to Github \n"
echo "https://github.com/account/ssh \n"
read -p "Press [Enter] key after this..."

echo "Installing xcode-stuff"
xcode-select --install

# Check if `homebrew` exists.
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing homebrew cask..."
brew install caskroom/cask/brew-cask

echo "Installing Git..."
brew install git

echo "Let's setup git..."

read -p "Enter email address for global git: " email
git config --global user.name "Ankur Kaushal"
git config --global user.email $email

touch ~/.global_gitignore
git config --global core.excludesfile "~/.global_gitignore"

git config --global branch.autosetuprebase "always"

echo "Installing zsh & oh-my-zsh..."
brew install zsh && chsh -s /bin/zsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

echo "Copying zshrc to ~"
mv ./zshrc ~/.zshrc

echo "Installing NVM & Node..."

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

read -p "Enter node version to install: " version

nvm install $version

echo "Installing aws-cli":
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

apps=(
  adobe-acrobat-reader
  alfred
  discord
  firefox
  google-chrome
  iterm2
  sublime-text
  vlc
  skype
  zoomus
  onepassword
  sequel-pro
  slack
  docker
  dbeaver-community
  visual-studio-code
)

echo "installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}
