{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    obs-studio
    v4l-utils
    ffmpeg-full
    webcamoid
  ];
}
