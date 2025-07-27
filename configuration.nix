{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./modules/desktop
      ./modules/system
      ./modules/services
    ];

  system.stateVersion = "24.11";

}
