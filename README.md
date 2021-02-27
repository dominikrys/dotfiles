# Dotfiles

Personal dotfiles for development on macOS (and Linux with some modifications), managed using [Mackup](https://github.com/lra/mackup).

To clone with submodules

```bash
git clone --recurse-submodules -j8 git@github.com:dominikrys/dotfiles.git
```

To pull submodules if the repo is already cloned

```bash
git submodule update --init --recursive
```

## Maintenance

If a submodule gets into a `dirty` state, run:

```bash
git submodule foreach --recursive git checkout .
```

## Making backups with Mackup

Backup your application settings

```bash
mackup backup
```

Back up Homebrew

```bash
brew bundle dump -f
```

To add more applications to be backed up, include them in `.mackup.cfg`.

## Other Mackup commands

Restore your application settings on a newly installed workstation

```bash
mackup restore
```

Copy back any synced config files to their original place

```bash
mackup uninstall
```

Display the list of applications supported by Mackup

```bash
mackup list
```

Show steps without executing

```bash
mackup backup -n
```
