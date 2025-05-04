# hosts/laptop/default.nix
{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/options.nix
    ../../modules/desktop
    ../../modules/system
    ../../modules/services
    ../../modules/hardware/laptop.nix
  ];

  # Disable NVIDIA for this machine
  hardware.nvidia.enable = false;
  hardware.isLaptop = true;

  # Machine-specific configurations
  networking.hostName = "nixtop";
  system.stateVersion = "24.11";
}
