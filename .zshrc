# zmodload zsh/zprof # Uncomment to profile startup time
#####################################################################
# Powerlevel10k
#####################################################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Solve issues with OMZ updates and P10k
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Always show Kubernetes context
# unset POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND

#####################################################################
# ZSH
#####################################################################

# Compinstall config
zstyle :compinstall filename "/Users/$USER/.zshrc"
autoload -Uz compinit
compinit

# Suppress compilation warnings
ZSH_DISABLE_COMPFIX=true

# Set ZSH theme
ZSH_THEME="powerlevel10k/powerlevel10k"

#####################################################################
# Oh My Zsh
#####################################################################

# Enable plugins
plugins=(
  # Built-in
  asdf
  colored-man-pages
  copybuffer
  copyfile
  copypath
  git
  history
  kubectl
  # Custom
  autoupdate
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-completions
  zshmarks
  )

# Enable OMZ
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Disable OMZ automatic updates
zstyle ':omz:update' mode disabled
export DISABLE_AUTO_UPDATE="true"

# Disable autoupdate-zsh-plugin automatic updating
export UPDATE_ZSH_DAYS=999

#####################################################################
# Configure tools
#####################################################################

# Add global yarn packages to path
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Add homebrew tools to path
export PATH=/opt/homebrew/bin:$PATH

# Configure direnv
eval "$(direnv hook zsh)"

# Configure cargo
export PATH="$HOME/.cargo/bin:$PATH"

case `uname` in
  Darwin)
    # Don't quarantine Brew casks
    export HOMEBREW_CASK_OPTS="--no-quarantine"
  ;;
esac

#####################################################################
# Aliases
#####################################################################

# Alias for scanning the current directory and adding git submodules (https://stackoverflow.com/a/10607225/13749561)
git-add-submodules() {
  for x in $(find . -mindepth 1 -type d) ; do
    if [ -d "${x}/.git" ] ; then
        cd "${x}"
        origin="$(git config --get remote.origin.url)"
        cd - 1>/dev/null
        git submodule add "${origin}" "${x}"
    fi
  done
}

# Alais for updating TPM plugins
alias tpm-update='~/.tmux/plugins/tpm/bin/update_plugins all'

# Alias for refreshing gitignore
alias git-refresh-gitignore='git rm -r --cached . && git add .'

# Alias for fetching and merging another branch into the current branch
gpo() {
  if [ -z "$1" ]
  then
    echo "ERROR: No branch name provided!"
  else
    git pull origin "$1:$1"
  fi
}

# Alias for updating tools
update() {
  echo "==> Updating TPM"
  tpm-update 
  echo "==> Updating tldr"
  tldr --update
  echo "==> Updating oh-my-zsh"
  omz update
  echo "==> Updating oh-my-zsh plugins"
  upgrade_oh_my_zsh_custom
}

case `uname` in
  Darwin)
    # Aliases for enabling dock resizing
    alias dock-lock='defaults write com.apple.Dock size-immutable -bool yes; killall Dock'
    alias dock-unlock='defaults write com.apple.Dock size-immutable -bool no; killall Dock'
    
    # Open file in sublime using `subl`
    ln -sf /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

    # Extend update function with macOS tools
    functions[original_update]=$functions[update]
    update () {
      echo "==> Upgrading Homebrew packages"
      brew upgrade
      echo "==> Cleaning unused Homebrew dependencies"
      brew autoremove

      original_update $@[@]
    }

    # Backup installed packages
    backup() {
      echo "==> Saving a list of Homebrew packages"
      brew bundle dump -f --file=~/Brewfile
      echo "==> Creating a backup with mackup"
      mackup backup -f
    }
    ;;
esac

# zprof # Uncomment to profile startup time