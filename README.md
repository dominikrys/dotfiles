# Dotfiles

Personal dotfiles for development on macOS and Linux, managed using [Mackup](https://github.com/lra/mackup).

To clone with submodules

```bash
git clone --recurse-submodules -j8 git@github.com:dominikrys/dotfiles.git
```

Fix permissions after cloning

```bash
chmod -R 775 dotfiles
```

To pull submodules if the repo is already cloned

```bash
git submodule update --init --recursive
```

## Making backups + maintenance

To add more applications to be backed up, include them in `.mackup.cfg`.

Backup application settings

```bash
mackup backup -f
```

Back up packages installed through Homebrew

```bash
brew bundle dump -f
```

Scan and add git submodules ([source](https://stackoverflow.com/questions/10606101/automatically-add-all-submodules-to-a-repo))

```bash
for x in $(find . -type d) ; do if [ -d "${x}/.git" ] ; then cd "${x}" ; origin="$(git config --get remote.origin.url)" ; cd - 1>/dev/null; git submodule add "${origin}" "${x}" ; fi ; done
```

If a git submodule gets into a `dirty` state, run:

```bash
git submodule foreach --recursive git checkout .
```

## Other Mackup commands

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

## Auto-updating oh-my-zsh plugins and themes

Add the following to `$ZSH/tools/upgrade.sh` before `exit $status` ([source](https://unix.stackexchange.com/questions/477258/how-to-auto-update-custom-plugins-in-oh-my-zsh/597740#597740)):

```zsh
printf "\n${BLUE}%s${RESET}\n" "Updating custom plugins and themes"
cd custom/
for plugin in plugins/*/ themes/*/; do
  if [ -d "$plugin/.git" ]; then
     printf "${YELLOW}%s${RESET}\n" "${plugin%/}"
     git -C "$plugin" pull
  fi
done
```
