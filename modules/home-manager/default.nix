{ pkgs, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "23.11";
  # specify my home-manager configs
  home.packages = with pkgs; [
    curl
    fd
    less
    ripgrep
  ];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
  programs.bat.enable = true;
  programs.bat.config.theme = "TwoDark";
  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;
  programs.eza.enable = true;
  programs.git.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "ls --color=auto -F";
      nv = "nvim";
      nixswitch = "darwin-rebuild switch --flake ~/.config/nix-darwin/.#";
      nixup = "pushd ~/src/system-config; nix flake update; nixswitch; popd";
    };
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd"];
  };
  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
  programs.alacritty = {
    enable = true;
    settings.font.normal.family = "JetBrainsMono Nerd Font Mono";
    settings.font.size = 14;
    settings.window.option_as_alt = "OnlyRight";
  };
  # home.file.".inputrc".source = ./dotfiles/inputrc;
}
