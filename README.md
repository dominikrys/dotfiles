# Dotfiles

Personal dotfiles for development on macOS, managed using [Mackup](https://github.com/lra/mackup).

## Making backups

Backup your application settings.

```bash
mackup backup
```

Back up Homebrew

```bash
brew bundle dump -f
```

To add more applications to be backed up, include them in `.mackup.cfg`.

## Other commands

Restore your application settings on a newly installed workstation.

```bash
mackup restore
```

Copy back any synced config files to their original place.

```bash
mackup uninstall
```

Display the list of applications supported by Mackup.

```bash
mackup list
```

Show steps without executing
```bash
mackup backup -n
```
