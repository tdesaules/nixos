# NixOS

## Getting Starteg

### configure hostname

#### use `dmidecode` to get the `system-uuid`

```bash
dmidecode -s system-uuid
```

#### configure hostname in `/etc/nixos/configuration.nix`

```nix
networking.hostName = "host-1c79a46e-73a7-7849-a6e3-82d1da5bca2a";
```

#### enable `flakes` and `nix-command` inside your `/etc/nixos/configuration.nix`

```nix
nix.settings.experimental-features = [
  "nix-command"
  "flakes"
]
```

#### rebuild nixos

```bash
sudo nixos-rebuild switch
sudo nixos-rebuild switch --impure
sudo nixos-rebuild switch --upgrade --impure
```

### others

### unstable channel

#### switch to the unstable channel and upgrade

```bash
sudo nix-channel --list
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
sudo nixos-rebuild switch --upgrade
```

#### in case of corruption

```bash
sudo nix-collect-garbage
sudo nix-store --verify --check-contents
sudo nix store repair --all
sudo nixos-rebuild switch --upgrade
```

#### clean boot entries

```bash
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system old
sudo nix-env --delete-generations --profile /nix/var/nix/profiles/system 1 2 3
```

#### test nix flake

```bash
sudo nix flake check /etc/nixos --impure
```