{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.hardware.nvidia.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      # Vulkan support packages
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];

      # 32-bit Vulkan support packages
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };

    # NVIDIA driver for Xorg and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;

      # For older cards the open driver is not supported
      open = false;

      nvidiaSettings = true;
      # Use the stable driver branch
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    # Add kernel parameters for better NVIDIA functionality
    boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  };
}
