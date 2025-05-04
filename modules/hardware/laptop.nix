# modules/hardware/laptop.nix
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.hardware.isLaptop {
    # Laptop-specific configurations
    services.tlp.enable = true; # For power management
    services.thermald.enable = true; # For temperature management

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # Additional laptop-specific packages
    environment.systemPackages = with pkgs; [
      acpi
      powertop
    ];
  };
}
