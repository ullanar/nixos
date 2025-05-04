{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;

    # Aliases for common commands
    shellAliases = {
      # NixOS rebuilding aliases
      nrsd = "sudo nixos-rebuild switch --flake /etc/nixos#nixarchy";
      nrsl = "sudo nixos-rebuild switch --flake /etc/nixos#nixlaptop";
      nrs = "sudo nixos-rebuild switch --flake /etc/nixos#$(hostname)";

      # Config editing aliases
      cfg = "nvim /etc/nixos";
      cfgd = "nvim /etc/nixos/hosts/nixarchy/default.nix";
      cfgl = "nvim /etc/nixos/hosts/laptop/default.nix";
      cfgh = "nvim /etc/nixos/home_manager/default.nix";

      # Other useful aliases
      update = "cd /etc/nixos && nix flake update";
      ls = "ls --color=auto";
      ll = "ls -la";
    };

    # History settings
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      share = true;
    };

    # Zsh plugins
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "sha256-gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
        };
      }
    ];

    # Additional Zsh settings
    initExtra = ''
      # Custom Zsh prompt
      PROMPT='%F{green}%n@%m%f:%F{blue}%~%f$ '
    '';
  };
}
