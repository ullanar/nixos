{ config, lib, pkgs, ... }:

{
  imports = [
    ./rust.nix
    ./c.nix
    ./cloud.nix
  ];

  home.packages = with pkgs; [
    go
    devbox
    neovim
    tmux
    terraform
    python3
    tilt
    dbeaver-bin
    postgresql
    flutter
    xdg-utils
    chromium
    deno
    nodejs_24
    ory
    insomnia
    lazygit
    lazydocker
    tiled
    zed-editor-fhs
    ansible
    clickhouse-cli
    openssl
    ooniprobe-cli
  ];
}
