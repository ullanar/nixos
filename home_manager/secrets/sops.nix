{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    defaultSopsFile = /etc/nixos/secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    
    secrets = {
      github_token = {
        path = "${config.home.homeDirectory}/.config/git/github-token";
        mode = "0600";
      };
    };
  };

  home.packages = with pkgs; [
    sops
    age
    ssh-to-age
  ];

  programs.git.extraConfig = {
    credential.helper = "!f() { echo username=oauth2; echo password=$(cat ${config.sops.secrets.github_token.path}); }; f";
  };
}
