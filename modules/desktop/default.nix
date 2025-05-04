{ config, lib, pkgs, ... }:

{
  imports = [
    ./kde.nix
    ./nvidia.nix
  ];
}
