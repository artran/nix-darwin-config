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
    ZSH_TMUX_AUTOSTART = "true";
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
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "history"
        "rust"
        "ssh-agent"
        "tmux"
      ];
    };
    shellAliases = {
      ls = "ls --color=auto -F";
      nv = "nvim";
      vimdiff = "nvim -d";
      ap = "ansible-playbook";
      getopt = "$(brew --prefix)/opt/gnu-getopt/bin/getopt";
      brewup = "brew update && brew upgrade && brew cleanup";
      whatsmyip = "dig +short ip @dns.toys";

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
