{ config, lib, pkgs, ... }:

{
  # Install rustup along with required system dependencies
  home.packages = with pkgs; [
    rustup
    pkg-config

    # Wayland dependencies
    wayland
    wayland-protocols
    libxkbcommon

    # ALSA dependencies
    alsa-lib

    # Udev dependencies
    systemd.dev # This provides libudev

    # Additional libraries that might be helpful for gamedev
    libGL
    vulkan-loader
    vulkan-headers
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi

    # Other common dependencies for Bevy
    fontconfig
    freetype
    libpulseaudio
  ];

  # Set up environment variables in your shell
  programs.bash.initExtra = ''
    # Set up cargo and rustup paths
    export PATH=$PATH:''${CARGO_HOME:-~/.cargo}/bin
    export RUSTUP_HOME=''${RUSTUP_HOME:-~/.rustup}
    
    # Add rustc and cargo to path once installed via rustup
    if [ -d "$RUSTUP_HOME/toolchains" ]; then
      export PATH=$PATH:$RUSTUP_HOME/toolchains/nightly-x86_64-unknown-linux-gnu/bin/
    fi
    
    # Set up pkg-config path to find necessary libraries
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:${pkgs.wayland.dev}/lib/pkgconfig:${pkgs.wayland-protocols}/lib/pkgconfig:${pkgs.alsa-lib.dev}/lib/pkgconfig:${pkgs.systemd.dev}/lib/pkgconfig"
    
    # Add LD_LIBRARY_PATH for runtime libraries if needed
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${lib.makeLibraryPath [
      pkgs.wayland
      pkgs.libxkbcommon
      pkgs.vulkan-loader
      pkgs.libGL
      pkgs.alsa-lib
      pkgs.systemd
    ]}"
  '';

  # Create a rust-toolchain.toml file in your home directory
  home.file.".rust-toolchain.toml".text = ''
    [toolchain]
    channel = "nightly"
    components = ["rustc", "cargo", "rust-std", "rust-src", "rustfmt", "clippy"]
  '';

  # Add the same config for zsh if you use it
  programs.zsh.initExtra = config.programs.bash.initExtra;

  home.activation = {
    installRustNightly = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD ${pkgs.rustup}/bin/rustup default nightly
      $DRY_RUN_CMD ${pkgs.rustup}/bin/rustup component add rust-src rustfmt clippy
    '';
  };
}
