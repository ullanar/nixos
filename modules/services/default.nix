{ config, lib, pkgs, ... }:

{
  imports = [
    ./pipewire.nix
  ];

  # Enable CUPS to print documents
  services.printing.enable = true;
}
