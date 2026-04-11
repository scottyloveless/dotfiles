export EZA_CONFIG_DIR="$HOME/.config/eza/"


# os specific - mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export XDG_CONFIG_HOME="$HOME/.config"
  export XDG_DATA_HOME="$HOME/.local/share"
  . "$HOME/.local/share/../bin/env"
  export PATH="/opt/homebrew/opt/curl/bin:$PATH"
  export PATH="/opt/homebrew/opt/sqlfluff/bin/:$PATH"
  export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
  export PATH=$PATH:$HOME/.local/share/nvim/mason/staging/nil/bin
fi

# os specific - linux
if [[ "$OSTYPE" == linux* ]]; then
  export PATH="/usr/bin/Hyprland:$PATH"
fi

export PATH=$PATH:$HOME/.local/bin

# ---- Go ----
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# immediate plugins
zinit light zsh-users/zsh-completions

# async plugins
zinit ice wait lucid 
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

# # Add in snippets
# zinit snippet OMZP::aws
# zinit snippet OMZP::command-not-found
# zinit snippet OMZP::docker
# zinit snippet OMZP::git
# zinit snippet OMZP::1password
# zinit snippet OMZP::brew

# Load compinit once a day
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
# Load After compinit
zinit light Aloxaf/fzf-tab
zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

#History
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

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color=always $realpath'

# Aliases
alias ls='eza --color=always --icons=always -l --group-directories-first'
alias ll='eza --color=always --icons=always --git --git-repos'
alias vim='nvim'
alias c='clear'
alias y='yazi'

# Neovim
export EDITOR=nvim
export VISUAL=nvim
vv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return
 
  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
}

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# postgres 
export PSQL_DIR=/opt/homebrew/Cellar/postgresql@17/17.9/bin
export PATH="$PSQL_DIR:$PATH"

# imagemagick-full
export PATH="/opt/homebrew/opt/imagemagick-full/bin:$PATH"

# tokyonight theme for fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --border=rounded \
  --color=border:#589ed7 \
  --color=fg:#c8d3f5 \
  --color=gutter:#1e2030 \
  --color=header:#ff966c \
  --color=hl+:#65bcff \
  --color=hl:#65bcff \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#ff966c \
  --color=spinner:#ff007c \
"

# ~/.zshrc
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/moxzen.toml)"
fi
