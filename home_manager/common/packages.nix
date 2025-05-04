{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Terminal utilities
    neovim
    tmux
    git

    # Communication
    discord
    telegram-desktop
    thunderbird

    # Fonts
    jetbrains-mono
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
  ];
}
