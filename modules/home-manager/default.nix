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
      extraConfig = ''
        zstyle :omz:plugins:ssh-agent ssh-add-args --apple-load-keychain
      '';
      plugins = [
        "git"
        "history"
        "rust"
        "ssh-agent"
        "tmux"
      ];
    };
    shellAliases = {
      "." = "source";
      cat = "bat";
      ls = "ls --color=auto -F";
      nv = "nvim";
      vimdiff = "nvim -d";
      ap = "ansible-playbook";
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
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    keyMode = "vi";
    prefix = "C-a";
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins; [
      battery
      power-theme
      vim-tmux-navigator
    ];
    extraConfig = ''
      set -g status-right '#{battery_status_bg} #{battery_percentage} #{battery_remain} | #{cpu_percentage} | %H:%M '
      run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
      run-shell ${pkgs.tmuxPlugins.battery}/share/tmux-plugins/battery/battery.tmux
      bind-key -T copy-mode-vi 'v' send -X begin-selection # start selecting text with "v"
      bind-key -T copy-mode-vi 'y' send -X copy-selection # copy text with "y"
      unbind -T copy-mode-vi MouseDragEnd1Pane # don't exit copy mode after dragging with mouse
      unbind %
      bind | split-window -h
      unbind '"'
      bind - split-window -v
    '';
  };
}
