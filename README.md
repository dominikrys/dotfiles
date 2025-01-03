# Dotfiles

Personal dotfiles for development on macOS and Linux managed using [Mackup](https://github.com/lra/mackup).

## Cloning

Clone with submodules:

```bash
git clone --recurse-submodules -j8 git@github.com:dominikrys/dotfiles.git
```

If the repo is already cloned, pull submodules:

```bash
git submodule update --init --recursive
```

## Post-Cloning Steps

Run Setup Script on macOS:

```bash
./macos-setup.sh
```

Run mackup:

```bash
cp .mackup.cfg ~
mackup restore
```

Fix OMZ and Mackup:

```sh
git clone https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv.git $ZSH_CUSTOM/plugins/autoswitch_virtualenv
git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins $ZSH_CUSTOM/plugins/autoupdate
git clone https://github.com/Aloxaf/fzf-tab $ZSH_CUSTOM/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/jocelynmallon/zshmarks $ZSH_CUSTOM/plugins/zshmarks
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
```

Make manual changes

- [Install the font for P10k](https://github.com/romkatv/powerlevel10k#manual-font-installation).

- [Set up executing sudo without a password](https://askubuntu.com/a/147265).

- Configure local-only changes in `~/.localrc.zsh`

- Install applications from the Brewfile.

- Configure iTerm to use the settings under `~/dev/dotfiles/Library/Preferences/com.googlecode.iterm2.plist`

- Blacklist some local-only changes in git:

  ```sh
  git update-index --assume-unchanged .tool-versions
  ```

- Go through the `misc` and company-specific directories for anything that needs to be restored manually.

- Configure system settings, Zoom settings, widgets sidebar, dock, menu bar, Finder sidebar, run all apps.

- Set up automation to run the Logseq backup script: [docs](https://stackoverflow.com/questions/36854193/scheduling-a-terminal-command-or-script-file-to-run-daily-at-a-specific-time-mac)

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

Fix updating Oh My Zsh ([source](https://github.com/lra/mackup/issues/1384#issuecomment-512667195)): from the `~/.oh-my-zsh` directory, run:

```sh
git checkout -b my-custom
git add .
git commit -m "fix mackup"
git checkout master
upgrade_oh_my_zsh
git merge my-custom
```

### Useful Mackup commands

Restore your application settings on a newly installed workstation

```bash
mackup restore
```

Display the list of applications supported by Mackup

```bash
mackup list
```

Copy back any synced config files to their original place

```bash
mackup uninstall
```
