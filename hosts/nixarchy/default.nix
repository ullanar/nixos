# hosts/nixarchy/default.nix
{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/options.nix
    ../../modules/desktop
    ../../modules/system
    ../../modules/services
  ];

  # Enable NVIDIA for this machine
  hardware.nvidia.enable = true;
  hardware.isLaptop = false;

  systemd.services.mount-media-disk = {
    description = "Mount media disk";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.util-linux}/bin/mount -o defaults /dev/disk/by-uuid/c3d261b0-a643-48e8-af33-8c1b534b4a81 /home/lev/media";
      ExecStop = "${pkgs.util-linux}/bin/umount /home/lev/media";
    };
  };

  # Machine-specific configurations
  networking.hostName = "nixarchy";
  system.stateVersion = "24.11";
}
