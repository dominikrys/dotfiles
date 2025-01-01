#!/bin/bash

#####################################################################
# General one-off install scripts for macOS
#####################################################################

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install tmux-256color to have colours in tmux
curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz
gunzip terminfo.src.gz
/usr/bin/tic -xe tmux-256color terminfo.src
rm terminfo.src

#####################################################################
# Configure "hidden" macOS settings
#####################################################################

# Always show hidden files in finder
defaults write com.apple.finder AppleShowAllFiles -boolean true
killall Finder

# Remove dock auto-hide animation and delay
defaults write com.apple.dock autohide-time-modifier -int 0
defaults write com.apple.dock autohide-delay -float 0
killall Dock

# Use list view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
sudo find / -name ".DS_Store" -exec rm {} \;

# Disable emoji suggestions: https://www.reddit.com/r/MacOS/comments/16wzdk9/is_there_a_way_to_turn_off_the_new_emoji/
sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist emoji_enhancements -dict-add Enabled -bool NO
