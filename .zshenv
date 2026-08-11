# Path modifications
export appendPath() {
  NEW_PATH=$1

  if [[ ":$PATH:" != *":$NEW_PATH:"* ]]; then
      export PATH="$PATH:$NEW_PATH"
  fi
}

appendPath "$HOME/.local/bin"
appendPath "$HOME/.dotnet/tools"
appendPath "$HOME/roslyn/linux-x64/"
appendPath "/snap/bin"

if [[ -d ~/dotfiles/$(hostname)/scripts ]]; then
  appendPath "$HOME/dotfiles/$(hostname)/scripts"
fi

source "$HOME/.zsh.secrets" 2> /dev/null
source "$HOME/.zshenv.$HOST" 2> /dev/null

FOSSA_TELEMETRY_SCOPE=off
