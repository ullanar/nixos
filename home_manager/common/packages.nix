{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Terminal utilities
    wezterm
    warp-terminal
    unzip
    unrar
    lsof
    argocd
    ripgrep
    easyeffects
    helvum
    obs-studio
    kdePackages.kdenlive
    qbittorrent-enhanced
    pyfa
    fd
    ghostty
    amneziawg-go
    neofetch
    htop
    krita
    vlc
    jq
    yq
    htop
    pwgen
    ncspot
    alsa-utils
    # Communication
    discord
    telegram-desktop
    thunderbird
    teams-for-linux
    teamspeak6-client
    mumble
    # Fonts
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.symbols-only
  ];
}
