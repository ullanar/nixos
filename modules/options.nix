# modules/options.nix
{ config, lib, pkgs, ... }:

with lib;

{
  options = {
    hardware.nvidia = {
      enable = mkEnableOption "NVIDIA graphics card support";
    };

    hardware.isLaptop = mkEnableOption "Laptop-specific configurations";
  };
}
