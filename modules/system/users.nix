{ config, lib, pkgs, ... }:

{
  programs.zsh.enable = true;

  # Define user account
  users.users.lev = {
    isNormalUser = true;
    description = "lev";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = [ ];
  };

  programs.firefox.enable = true;

  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
