{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    awscli2
    kubectl
    k9s
    nomad
    talosctl
    terraformer
    cilium-cli
    kubernetes-helm
  ];
}
