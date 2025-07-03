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

export NVM_DIR="$HOME/.nvm"
export HOMEBREW_PREFIX=$(brew --prefix)  # Explicitly set Homebrew prefix

# Load NVM
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
# Load NVM bash_completion
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

kindle_ip="192.168.100.174"

export PATH="$PATH:/Users/eduardogdebem/.dotnet/tools"
