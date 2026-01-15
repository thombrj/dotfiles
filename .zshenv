alias pdt="flatpak run io.podman_desktop.PodmanDesktop"

# Path modifications
appendPath() {
  export PATH="$PATH:$1"
}

appendPath "$HOME/.local/bin"
appendPath "$HOME/.dotnet/tools"
appendPath "$HOME/roslyn/linux-x64/"
appendPath "$HOME/.pulumi/bin"
appendPath "/opt/azure-functions-cli"
appendPath "/snap/bin"

source $HOME/.zshsecrets
