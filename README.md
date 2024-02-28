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

- Configure system settings, Zoom settings, widgets sidebar, dock, menu bar, run all apps, 

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

Display the list of applications supported by Mackup

```bash
mackup list
```

Copy back any synced config files to their original place

```bash
mackup uninstall
```
