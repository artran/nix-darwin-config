# Nix Darwin Config

My configuration for a Mac used as a development workstation.

It's inspired by and based on [this repo](https://github.com/zmre/mac-nix-simple-example)
and the YouTube video that goes with it.

## Aims

I want the following features:

- Alacritty terminal
- ZSH with OhMyZSH and Starship
- Tmux with Powerline
- Neovim with customisation for development
- Rust
- Suitable NerdFonts

## Initial Nix installation

- Use the [determinate systems GUI installer](https://determinate.systems/posts/graphical-nix-installer)
- Install [nix-darwin](https://github.com/LnL7/nix-darwin):

```sh
mkdir -p ~/.config/nix-darwin
cd ~/.config/nix-darwin
nix flake init -t nix-darwin
sed -i '' "s/simple/$(scutil --get LocalHostName)/" flake.nix
nix run nix-darwin -- switch --flake ~/.config/nix-darwin
```

- Fix the `NIX_PATH`:

```sh
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable
sudo nix-channel --update
```

- Then replace the config with this repo:
  - `rm -rf ~/.config/nix-darwin`
  - `git clone git@github.com:artran/nix-darwin-config.git ~/.config/nix-darwin`
- And _switch_ into the new system
  - `darwin-rebuild switch --flake ~/.config/nix-darwin`

## Extra steps for Neovim (optional)

This will install neovim but I use [Astronvim](https://astronvim.com) so to get
the full features that will need to be installed after the nix rebuild. The
minimal steps to install are:

- `git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim`
- `git clone https://github.com/<username>/<config_repo> ~/.config/nvim/lua/user`

The config repo is based on the template project provided by Astronvim and
described [here](https://docs.astronvim.com/#%EF%B8%8F-configuration)

## Setup GPG for signing git commits

- `nv ~/.gnupg/gpg-agent.conf`
- Add `pinentry-program /usr/local/bin/pinentry`
- Import or generate your keys

## Setup the password manager

- See [the web page](https://www.passwordstore.org) for details
- Either `pass init "<GPG_Key_ID>"`
- Or `git clone git@github.com:<USER>/.password-store.git ~/.password-store`
