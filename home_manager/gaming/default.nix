{ config, lib, pkgs, ... }:

{
  imports = [
    ./steam.nix
    ./xiv.nix
  ];
}
