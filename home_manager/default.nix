{ config, lib, pkgs, ... }:

{
  imports = [
    ./common
    ./dev
    ./gaming
    ./machine
    # ./secrets
  ];

  # Basic user information
  home.username = "lev";
  home.homeDirectory = "/home/lev";
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Fonts configuration for user apps
  fonts.fontconfig.enable = true;
}
