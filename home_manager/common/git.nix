{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Lev Bubnov";
    userEmail = "lb@ywa.red";

    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = false;
      core.editor = "nvim";
      color.ui = true;
    };
  };
}
