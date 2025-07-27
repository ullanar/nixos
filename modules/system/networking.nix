{ config, lib, pkgs, ... }:

{
  # Define hostname
  networking.hostName = "nixarchy";

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  networking.wireguard.enable = true;
  networking.firewall.enable = false;
}
