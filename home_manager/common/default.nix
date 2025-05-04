{ config, lib, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./kitty.nix
    ./zsh.nix
    ./git.nix
  ];
}
