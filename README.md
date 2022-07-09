# Dotfiles

Personal dotfiles for development on macOS and Linux, managed using [Mackup](https://github.com/lra/mackup).

## Cloning

Clone with submodules

```bash
git clone --recurse-submodules -j8 git@github.com:dominikrys/dotfiles.git
```

Fix permissions after cloning

```bash
chmod -R 775 dotfiles
```

Pull submodules if the repo is already cloned

```bash
git submodule update --init --recursive
```

## Post-Cloning Steps

### Install tmux-256color on macOS

```bash
curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz
gunzip terminfo.src.gz
/usr/bin/tic -xe tmux-256color terminfo.src
rm terminfo.src
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

### TODO

- [ ] Properly link/structure files in `misc`
