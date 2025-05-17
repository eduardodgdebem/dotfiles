export PATH="/opt/homebrew/bin:$PATH"

if whence dircolors >/dev/null; then
  eval "$(dircolors -b)"
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  alias ls='ls --color'
  alias dir='dir --color'
  alias vdir='vdir --color'
  alias grep='grep --color'
  alias fgrep='fgrep --color'
  alias egrep='egrep --color'
else
  export CLICOLOR=1
  zstyle ':completion:*:default' list-colors ''
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

eval "$(starship init zsh)"
