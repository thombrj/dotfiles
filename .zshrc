
eval `keychain --eval --quiet`

# Custom host .zshrc files
if [ -f "$HOME/$(hostname).zshrc" ]; then
    source "$HOME/$(hostname).zshrc"
fi

# zinit (zsh extensions)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -U compinit && compinit

# Key bindings
bindkey -s ^f "~/dotfiles/scripts/tmux-sessionizer\n"
bindkey '^H' backward-kill-word
bindkey "^[[3~" delete-char
bindkey "5~" kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
zle -N killp{,}
bindkey "^[Q" killp
bindkey '^[[Z' autosuggest-accept

# Alias'
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alG'
alias ls='ls --color'
alias azuritedev='~/dotfiles/scripts/azurite.sh'
alias voteapi="tmux new-session -s voteapi -c ~/dev/VoteAppSwa/src/Api 'func host start'"
alias voteapp="tmuxifier load-session voteapp"
alias zshrc="nvim ~/.zshrc"
alias lg="lazygit"
alias ..="cd .."
alias daprstartup="podman start \$(podman container list -a -f \"name=dapr\" -q)"
alias tf=terraform

# Functions
killp() {
    local pid=$(ps -ef | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[kill:process]'" | awk '{print $2}')
    if [[ "$pid" != "" ]]; then
        echo $pid | xargs sudo kill -${1:-9}
    fi
}

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

## Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Path modifications
appendPath() {
  export PATH="$PATH:$1"
}

appendPath "/opt/azure-functions-cli"
appendPath "$HOME/.local/bin"
appendPath "$HOME/.dotnet/tools"
appendPath "/snap/bin"
appendPath "$HOME/.tmuxifier/bin"

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/my-prompt.yaml)"
eval "$(fzf --zsh)"
