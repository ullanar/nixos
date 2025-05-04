{ config, lib, pkgs, ... }:

{
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Add common KDE applications
  environment.systemPackages = with pkgs; [
    kdePackages.kate
  ];
}
