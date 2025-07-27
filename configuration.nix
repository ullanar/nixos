{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./modules/desktop
      ./modules/system
      ./modules/services
    ];

  system.stateVersion = "25.05";

}
