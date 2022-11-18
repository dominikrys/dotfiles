# Dotfiles

Personal dotfiles for development on macOS and Linux, managed using [Mackup](https://github.com/lra/mackup).

## Cloning

Clone with submodules

```bash
git clone --recurse-submodules -j8 git@github.com:dominikrys/dotfiles.git
```

### If the repo is already cloned

Pull submodules

```bash
git submodule update --init --recursive
```

## Post-Cloning Steps

### Run mackup

```bash
cp .mackup.cfg ~
mackup restore
```

### Install tmux-256color on macOS

```bash
curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz
gunzip terminfo.src.gz
/usr/bin/tic -xe tmux-256color terminfo.src
rm terminfo.src
```

### Configure Hidden macOS settings

```bash
# Always show hidden files in finder
defaults write com.apple.finder AppleShowAllFiles -boolean true; killall Finder; 

# Remove dock auto-hide animation and delay
defaults write com.apple.dock autohide-time-modifier -int 0; defaults write com.apple.dock autohide-delay -float 0; killall Dock 

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
sudo find / -name ".DS_Store" -exec rm {} \; # Clear remembered views
```

### Install oh-my-zsh

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Install font for p10k

[Font install instructions](https://github.com/romkatv/powerlevel10k#manual-font-installation)

### Extra

Go through the `misc` directory to see if anything has been missed.

[Execute sudo without password](https://askubuntu.com/a/147265).

## Making backups & maintenance

> To add more applications to be backed up, include them in `.mackup.cfg`.

Backup application settings and make a list of Homebrew packages

```bash
backup
```

Scan and add git submodules

```bash
git-add-submodules
```

Fix a git submodule in a `dirty` state

```bash
git submodule foreach --recursive git checkout .
```

### Useful Mackup commands

Restore your application settings on a newly installed workstation

```bash
mackup restore
```

Show steps without executing

```bash
mackup backup -n
```

Display the list of applications supported by Mackup

```bash
mackup list
```

Copy back any synced config files to their original place

```bash
mackup uninstall
```

## TODO

- Automate font install
