zinit light mafredri/zsh-async
autoload -Uz async && async

# Git info
autoload -Uz vcs_info

() {
  zstyle ':vcs_info:*' enable git hg
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr "%F{green}•%f" # default 'S'
    zstyle ':vcs_info:*' unstagedstr "%F{red}•%f" # default 'U'
    zstyle ':vcs_info:*' use-simple true
    zstyle ':vcs_info:git+set-message:*' hooks git-untracked
    zstyle ':vcs_info:git*:*' formats '[%b%m%c%u] ' # default ' (%s)-[%b]%c%u-'
    zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u] ' # default ' (%s)-[%b|%a]%c%u-'
    zstyle ':vcs_info:hg*:*' formats '[%m%b] '
    zstyle ':vcs_info:hg*:*' actionformats '[%b|%a%m] '
    zstyle ':vcs_info:hg*:*' branchformat '%b'
    zstyle ':vcs_info:hg*:*' get-bookmarks true
    zstyle ':vcs_info:hg*:*' get-revision true
    zstyle ':vcs_info:hg*:*' get-mq false
    zstyle ':vcs_info:hg*+gen-hg-bookmark-string:*' hooks hg-bookmarks
    zstyle ':vcs_info:hg*+set-message:*' hooks hg-message

    function +vi-hg-bookmarks() {
      emulate -L zsh
        if [[ -n "${hook_com[hg-active-bookmark]}" ]]; then
          hook_com[hg-bookmark-string]="${(Mj:,:)@}"
            ret=1
            fi
    }

  function +vi-hg-message() {
    emulate -L zsh

# Suppress hg branch display if we can display a bookmark instead.
      if [[ -n "${hook_com[misc]}" ]]; then
        hook_com[branch]=''
          fi
          return 0
  }

  function +vi-git-untracked() {
    emulate -L zsh
      if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
        hook_com[unstaged]+="%F{blue}•%f"
          fi
  }
}

-start-async-vcs-info-worker() {
  async_start_worker vcs_info
    async_register_callback vcs_info -async-vcs-info-worker-done
}

-get-vcs-info-in-worker() {
# -q stops chpwd hook from being called:
  cd -q $1
    vcs_info
    print ${vcs_info_msg_0_}
}

-async-vcs-info-worker-done() {
  local job=$1
    local return_code=$2
    local stdout=$3
    local more=$6
    if [[ $job == '[async]' ]]; then
      if [[ $return_code -eq 1 ]]; then
# Corrupt worker output.
        return
          elif [[ $return_code -eq 2 || $return_code -eq 3 || $return_code -eq 130 ]]; then
# 2 = ZLE watcher detected an error on the worker fd.
# 3 = Response from async_job when worker is missing.
# 130 = Async worker crashed, this should not happen but it can mean the
# file descriptor has become corrupt.
#
# Restart worker.
          async_stop_worker vcs_info
          -start-async-vcs-info-worker
          return
          fi
          fi
          vcs_info_msg_0_=$stdout
          (( $more )) || zle reset-prompt
}

-clear-vcs-info-on-chpwd() {
  vcs_info_msg_0_=
}

-trigger-vcs-info-run-in-worker() {
  async_flush_jobs vcs_info
    async_job vcs_info -get-vcs-info-in-worker $PWD
}

-start-async-vcs-info-worker
add-zsh-hook precmd -trigger-vcs-info-run-in-worker
add-zsh-hook chpwd -clear-vcs-info-on-chpwd

RPROMPT_BASE="\${vcs_info_msg_0_}%F{blue}%~%f"
setopt PROMPT_SUBST

function -update-ps1() {
# Check for tmux by looking at $TERM, because $TMUX won't be propagated to any
# nested sudo shells but $TERM will.
  local TMUXING=$([[ "$TERM" =~ "tmux" ]] && echo tmux)
    if [ -n "$TMUXING" -a -n "$TMUX" ]; then
# In a tmux session created in a non-root or root shell.
      local LVL=$(($SHLVL - 1))
        elif [ -n "$XAUTHORITY" ]; then
# Probably in X on Linux.
        local LVL=$(($SHLVL - 2))
    else
# Either in a root shell created inside a non-root tmux session,
# or not in a tmux session.
      local LVL=$SHLVL
        fi

# OSC-133 escape sequences for prompt navigation.
#
# See: https://gitlab.freedesktop.org/Per_Bothner/specifications/blob/master/proposals/semantic-prompts.md
#
# tmux only cares about $PROMPT_START, but we emit other escapes just for
# completeness (see also, `-mark-output()`, further down).
        local PROMPT_START=$'\e]133;A\e\\'
        local PROMPT_END=$'\e]133;B\e\\'

# %F{green}, %F{blue}, %F{yellow} etc... = change foreground color
# %f = turn off foreground color
# %n = $USER
# %m = hostname up to first "."
# %B = bold on, %b = bold off
        local SSH_USER_AND_HOST="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b"

# %1~ = show 1 trailing component of working directory, or "~" if is is $HOME
        local CURRENT_DIRECTORY="%F{blue}%B%1~%b"

# Show last `tw` or `tick` step in bold yellow.
        local TW_SUMMARY="%F{yellow}%B(${TW})%b%f"

# %(1j.*.) = bold yellow "*" if the number of jobs is at least 1
        local JOB_STATUS_INDICATOR="%F{yellow}%B%(1j.*.)%b%f"

# %(?..!) = bold yellow "!" if the exit status of the last command was not 0
        local EXIT_STATUS_INDICATOR="%F{yellow}%B%(?..!)%b%f"

        local PROMPT_SEPARATOR=" "

# %(!.%F{yellow}%n%f.) = if root (!) show yellow $USER, otherwise nothing.
        local USER_INDICATOR="%B%(!.%F{yellow}%n%f.)%b"

# show one ❯ per $LVL
        local PROMPT_CHARACTERS="$(printf '\u276f%.0s' {1..$LVL})"

# $(!.%F{yellow}.%F{red})$(...) = use bold yellow for root, otherwise bold red
        local FINAL_PROMPT_MARKER="%B%(!.%F{yellow}.%F{red})${PROMPT_CHARACTERS}%f%b"

        PS1="%{${PROMPT_START}%}"
        PS1+="${SSH_USER_AND_HOST}"
        PS1+="${CURRENT_DIRECTORY}"
        if [ -n "$GIT_COMMITTER_DATE" -a -n "$GIT_AUTHOR_DATE" -a -n "$TW" ]; then
          PS1+="${TW_SUMMARY}"
            fi
            PS1+="${JOB_STATUS_INDICATOR}"
            PS1+="${EXIT_STATUS_INDICATOR}"
            PS1+="${PROMPT_SEPARATOR}"
            PS1+="${USER_INDICATOR}"
            PS1+="${FINAL_PROMPT_MARKER}"
            PS1+="%{${PROMPT_END}%}"
            PS1+="${PROMPT_SEPARATOR}"
            export PS1

            if [[ -n "$TMUXING" ]]; then
# Outside tmux, ZLE_RPROMPT_INDENT ends up eating the space after PS1, and
# prompt still gets corrupted even if we add an extra space to compensate.
              export ZLE_RPROMPT_INDENT=0
                fi
}

add-zsh-hook precmd -update-ps1

add-zsh-hook precmd -update-title-precmd

function -set-tab-and-window-title() {
  emulate -L zsh
    local TITLE="${1:gs/$/\\$}"
    print -Pn "\e]0;$TITLE:q\a"
}
function -title-command() {
  emulate -L zsh
    setopt EXTENDED_GLOB

    echo "${1[(wr)^(*=*|mosh|ssh|sudo|-*)]:gs/%/%%}"
}

# Executed before displaying prompt.
function -update-title-precmd() {
  emulate -L zsh
    setopt EXTENDED_GLOB
    setopt KSH_GLOB
    local LAST=$(fc -l -1)
    LAST="${LAST## #}" # Trim leading whitespace.
    LAST="${LAST##*([^[:space:]])}" # Remove first word (history number).
    LAST="${LAST## #}" # Trim leading whitespace.
    if [ -n "$TMUX" ]; then
# Inside tmux, just show the last command: tmux will prefix it with the
# session name (for context).
      -set-tab-and-window-title "$(-title-command "$LAST")"
    else
# Outside tmux, show $PWD (for context) followed by the last command.
      -set-tab-and-window-title "$(-forkless-basename) • $(-title-command "$LAST")"
        fi
}

function -update-rprompt() {
  emulate -L zsh
    if [ $ZSH_START_TIME ]; then
      local DELTA=$(($SECONDS - $ZSH_START_TIME))
        local DAYS=$((~~($DELTA / 86400)))
        local HOURS=$((~~(($DELTA - $DAYS * 86400) / 3600)))
        local MINUTES=$((~~(($DELTA - $DAYS * 86400 - $HOURS * 3600) / 60)))
        local SECS=$(($DELTA - $DAYS * 86400 - $HOURS * 3600 - $MINUTES * 60))
        local ELAPSED=''
        test "$DAYS" != '0' && ELAPSED="${DAYS}d"
        test "$HOURS" != '0' && ELAPSED+="${HOURS}h"
        test "$MINUTES" != '0' && ELAPSED+="${MINUTES}m"
        if [ "$ELAPSED" = '' ]; then
          SECS="$(print -f "%.2f" $SECS)s"
            elif [ "$DAYS" != '0' ]; then
            SECS=''
        else
          SECS="$((~~$SECS))s"
            fi
            ELAPSED+="${SECS}"
            export RPROMPT="%F{cyan}%{$__WINCENT[ITALIC_ON]%}${ELAPSED}%{$__WINCENT[ITALIC_OFF]%}%f $RPROMPT_BASE"
            unset ZSH_START_TIME
    else
      export RPROMPT="$RPROMPT_BASE"
        fi
}

add-zsh-hook precmd -update-rprompt
