# Instructions
- `mkdir -p ~/.config/nix; echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf`
- install [nix](https://nixos.org/download/)
- run `nix-shell -p home-manager`
- clone [kickstart.nix](https://github.com/AyMeeko/kickstart.nix)
- run `make popos`

# Nuances
## NixGL
This is for fixing wezterm installation and it seems like the PR is close to being merged?
https://github.com/nix-community/nixGL
https://github.com/nix-community/home-manager/issues/3968


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
