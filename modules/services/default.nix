{ config, lib, pkgs, ... }:

{
  imports = [
    ./pipewire.nix
  ];

  virtualisation.docker.enable = true;

  services.printing.enable = true;
}
