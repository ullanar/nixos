{ config, lib, pkgs, ... }:

{
  imports = [
    ./rust.nix
    ./c.nix
    ./cloud.nix
  ];
  
  home.packages = with pkgs; [
    go
  ];
}
