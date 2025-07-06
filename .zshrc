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

#####################################################################
# ZSH
#####################################################################

# Compinstall config
zstyle :compinstall filename "/Users/$USER/.zshrc"

# Suppress compilation warnings
ZSH_DISABLE_COMPFIX=true

# Set ZSH theme
ZSH_THEME="powerlevel10k/powerlevel10k"

#####################################################################
# Oh My Zsh
#####################################################################

# Make OMZ work with symlinked custom directory from mackup (https://github.com/lra/mackup/issues/1384#issuecomment-766814785)
ZSH_CUSTOM=${HOME}/dev/dotfiles/.oh-my-zsh/custom

# Enable plugins
plugins=(
  # Built-in
  aliases
  asdf
  brew
  copybuffer
  copyfile
  copypath
  direnv
  docker
  fzf
  gcloud
  git
  golang
  kubectl
  sublime
  # Custom
  autoswitch_virtualenv
  autoupdate
  fzf-tab
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting
  zshmarks
  )

# Disable OMZ automatic updates
zstyle ':omz:update' mode disabled

# Disable autoupdate zsh plugin automatic updating as we do it manually
export UPDATE_ZSH_DAYS=9999

# Enable OMZ
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

#####################################################################
# Configure tools
#####################################################################

case `uname` in
  Darwin)
    # Don't quarantine Brew casks
    export HOMEBREW_CASK_OPTS="--no-quarantine"

    # Disable brew analytics
    export HOMEBREW_NO_ANALYTICS=1
  ;;
esac

# Configure Go
if which go >/dev/null; then
  export GOPATH=$HOME/go
  export PATH=$GOPATH/bin:$PATH
fi

#####################################################################
# Aliases
#####################################################################

alias kctx='kubectx'
alias lzd='lazydocker'
alias cls='tput reset'                                          # Clear screen
alias tpm-update='~/.tmux/plugins/tpm/bin/update_plugins all'   # Update TPM plugins
alias git-refresh-gitignore='git rm -r --cached . && git add .' # Refresh .gitignore
alias gstst='git stash --keep-index'                            # Stash unstaged changes

# Scan the current directory and add found git submodules (https://stackoverflow.com/a/10607225/13749561)
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

# Fetch and merge the specified branch into the current branch
gpo() {
  BRANCH_NAME="$1"

  if [ -z "$BRANCH_NAME" ]
  then
    echo "ERROR: No branch name provided!"
    exit 1
  fi
  
  git pull origin "$BRANCH_NAME:$BRANCH_NAME"
}

# Fetch and rebase the specified branch into the current branch
gro() {
  BRANCH_NAME="$1"

  if [ -z "$BRANCH_NAME" ]
  then
    echo "ERROR: No branch name provided!"
    exit 1
  fi
  
  git pull origin --rebase "$BRANCH_NAME:$BRANCH_NAME"
}

# Toggle notch using znotch
toggle-notch() {
  if [ ! -d "/Applications/zNotch.app" ]; then
    echo "zNotch not installed."
    return 0
  fi

  open 'xyz.kondor.znotch://v1/manage?action=toggle'
}

# Rebase dependabot PRs in specified repo
rebase-dependabot() {
  REPO="$1"

  if [ -z "$REPO" ]
  then
    echo "ERROR: No repo name provided! The repo name format is `<org>/<repo>`"
    exit 1
  fi

  gh search prs \
    --repo $REPO \
    --state open \
    --label dependencies \
    --limit 200 \
    --json "url" --jq ".[] | .url" \
  | xargs -n 1 -I{} \
  gh pr comment -b "@dependabot rebase" {}
}

# Update tools
update() {
  echo "==> Updating TPM"
  tpm-update 

  echo "==> Updating tldr"
  tldr --update

  echo "==> Updating oh-my-zsh plugins"
  upgrade_oh_my_zsh_custom

  # Keep updateing OMZ at the end as it sometimes kills the script
  echo "==> Updating oh-my-zsh"
  # Pull the repo to get around error `error: 'custom/example.zsh' is beyond a symbolic link`
  (cd ~/.oh-my-zsh && git checkout master && git pull)
  omz update
}

# Platform-specific aliases
case `uname` in
  Darwin)
    # Aliases for enabling dock resizing
    alias dock-lock='defaults write com.apple.Dock size-immutable -bool yes; killall Dock'
    alias dock-unlock='defaults write com.apple.Dock size-immutable -bool no; killall Dock'

    # Extend update function with macOS tools
    functions[base_update]=$functions[update]
    update () {
      echo "==> Upgrading Homebrew packages"
      brew upgrade

      echo "==> Cleaning unused Homebrew dependencies"
      brew autoremove

      base_update $@[@]
    }

    # Backup installed packages
    backup() {
      echo "==> Saving a list of Homebrew packages"
      brew bundle dump -f --file=~/Brewfile

      echo "==> Creating a backup with mackup"
      mackup backup --force

      # Necessary as mackup is broken on Sonoma. More info: https://github.com/lra/mackup/issues/1924#issuecomment-2032982796
      mackup uninstall --force
    }
    ;;
esac

alias gce='git commit --allow-empty -m "Empty commit"'

# Temporarily fix python
export PATH="$(brew --prefix)/opt/python@3.12/libexec/bin:$PATH"

#####################################################################
# Optional
#####################################################################

# Source local-only changes
if [[ -f "$HOME/.localrc.zsh" ]]; then
  source "$HOME/.localrc.zsh"
fi

# Always show Kubernetes context
# unset POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND

#####################################################################
# Useful commands
#####################################################################

# `als` -> See aliases

#####################################################################
# End of customisation
#####################################################################

# zprof # Uncomment to profile startup time
