## Setup
### Linux
- ensure `~/.config/nix/nix.conf` exists with `experimental-features = nix-command flakes` in it.
- install nix
- run `nix-shell -p neovim home-manager`
- download kickstart.nix
- run `make`

### Darwin
- install nix
- clone kickstart.nix
- `nix run nix-darwin --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake .#macmini-aymeeko`

## simple-homemanager
https://github.com/Evertras/simple-homemanager/tree/main

## NixGL
This is for fixing wezterm installation and it seems like the PR is close to being merged?
https://github.com/nix-community/nixGL
https://github.com/nix-community/home-manager/issues/3968


## telescope-fzf-native

For some reason, you have to cd into
```
.local/share/nvim/lazy/telescope-fzf-native.nvim
```
and run `make`

## Kmonad
```
sudo groupadd uinput
sudo usermod -aG input aymeeko
sudo usermod -aG uinput aymeeko
sudo vi /lib/udev/rules.d/kmonad.rules

paste in:
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"

systemctl --user daemon-reload
systemctl --user enable kmonad
systemctl --user start kmonad.service
```


## WSL

Custom font support:
```
$ mkdir ~/.fonts
$ cp [fonts] ~/.fonts/
```

Install font utilities:
```
$ sudo apt update
$ sudo apt install fontconfig
$ fc-cache -f -v
```

## Packages to try to manage with nix
- karabiner-elements
- slack
