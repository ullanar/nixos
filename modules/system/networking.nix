{ config, lib, pkgs, ... }:

{
  # Define hostname
  networking.hostName = "nixarchy";

  # Enable NetworkManager
  networking.networkmanager.enable = true;
}
