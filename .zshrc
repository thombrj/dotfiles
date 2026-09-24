if command -v keychain > /dev/null 2>&1 ; then
  eval `keychain --eval --quiet`
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
bindkey -s ^f "~/dotfiles/scripts/tmux/tmux-sessionizer\n"
# bindkey '^H' backward-kill-word
bindkey "^[[3~" delete-char
bindkey "5~" kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^[[Z' autosuggest-accept

# Alias'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alG'
alias ls='ls --color'
alias azuritedev='~/dotfiles/scripts/azurite.sh'
command -v nvim &> /dev/null && alias vim="nvim"
alias zshrc="vim ~/.zshrc"
alias nvimconf="vim ~/.config/nvim"
alias Vim="/usr/bin/vim"
alias lg="lazygit"
alias ..="cd .."
alias ...="cd ..."
alias tf=terraform
alias pd=pushd
alias pod=popd

# Functions

killp() {
    local pid=$(ps -ef | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[kill:process]'" | awk '{print $2}')
    if [ "$pid" != "" ]; then
        echo $pid | xargs sudo kill -${1:-9}
    fi
}

scratch() {
  local dir=$(mktemp -d)
  pushd $dir
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
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'

source ~/.zshrc.prompt

source "$HOME/.zshrc.$HOST" 2> /dev/null

eval "$(fzf --zsh)"

[ -f ~/.linuxbrew/bin/brew ] && eval $(~/.linuxbrew/bin/brew shellenv)
command -v brew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
