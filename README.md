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

### Run Setup Script on macOS

```bash
./macos-setup.sh
```

### Extra

- [Install the font for P10k](https://github.com/romkatv/powerlevel10k#manual-font-installation).

- Go through the `misc` directory for anything that needs to be restored manually.

- [Set up executing sudo without a password](https://askubuntu.com/a/147265).

- Configure local-only changes in `~/.localrc.zsh`

- Blacklist some local-only changes in git:

  ```sh
  git update-index --assume-unchanged .tool-versions
  ```

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
