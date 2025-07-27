{ config, lib, pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./networking.nix
    ./users.nix
  ];
  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Enable flakes and other experimental features
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.auto-optimise-store = true;
  };
  programs.bash = {
    completion.enable = true;
  };
  # System-wide packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    bash
    wineWowPackages.stable
  ];
  # Fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];
  system.stateVersion = "24.11";
}
