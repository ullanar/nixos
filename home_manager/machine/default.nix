{ config, lib, pkgs, ... }:

{
  imports = [
    (if builtins.getEnv "HOSTNAME" == "nixarchy" then ./desktop.nix else ./laptop.nix)
  ];
}
