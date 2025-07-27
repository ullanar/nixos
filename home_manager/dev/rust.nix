{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    (rust-bin.nightly.latest.complete.override {
      extensions = [ 
        "rust-src"
        "rust-analyzer"
        "rustfmt"
        "clippy"
        "llvm-tools-preview"
        "rustc-codegen-cranelift-preview"
      ];
      targets = [ 
        "x86_64-unknown-linux-gnu"
        "wasm32-unknown-unknown"
      ];
    })

    dioxus-cli

    pkg-config
    gcc
    cmake
    gnumake

    openssl
    openssl.dev

    mold
    sccache

    alsa-lib
    alsa-lib.dev
    udev.dev
    wayland
    wayland-protocols
    libxkbcommon
    libGL
    vulkan-loader
    vulkan-headers
    vulkan-tools
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXi
    xorg.libXinerama
    fontconfig
    freetype

    pipewire
    libpulseaudio

    cargo-watch
    cargo-edit
    cargo-expand
    cargo-outdated
    cargo-audit
    bacon

    cargo-nextest
    cargo-machete
    cargo-bloat
    cargo-udeps
    cargo-cache
    
    wasm-pack
    wasm-bindgen-cli
    binaryen
  ];

  home.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
  };

  programs.bash.initExtra = ''
    export PATH="${pkgs.mold}/bin:$HOME/.local/bin:$PATH"
    export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.alsa-lib.dev}/lib/pkgconfig:${pkgs.udev.dev}/lib/pkgconfig:${pkgs.wayland.dev}/lib/pkgconfig:${pkgs.wayland-protocols}/share/pkgconfig:${pkgs.libxkbcommon}/lib/pkgconfig:$PKG_CONFIG_PATH"
    export LD_LIBRARY_PATH="${lib.makeLibraryPath [
      pkgs.openssl
      pkgs.wayland
      pkgs.libxkbcommon
      pkgs.vulkan-loader
      pkgs.libGL
      pkgs.alsa-lib
      pkgs.udev
      pkgs.xorg.libX11
      pkgs.xorg.libXcursor
      pkgs.xorg.libXrandr
      pkgs.xorg.libXi
    ]}:$LD_LIBRARY_PATH"
  '';
  
  programs.zsh.initContent = ''
    export PATH="${pkgs.mold}/bin:$HOME/.local/bin:$PATH"
  '' + config.programs.bash.initExtra;

  # Cargo configuration
  home.file.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker = "gcc"
    rustflags = [
      "-C", "link-arg=-fuse-ld=mold",
      "-C", "link-arg=-Wl,--compress-debug-sections=zlib"
    ]

    [target.wasm32-unknown-unknown]
    # No special configuration needed for WASM

    [build]
    jobs = -1  # Use all available cores

    # Development profile - fast builds, reasonable runtime performance
    [profile.dev]
    opt-level = 1      # Basic optimizations
    debug = 0          # No debug info for faster builds (use 2 if debugging)
    lto = false        
    incremental = true 
    split-debuginfo = "unpacked"  # Faster on Linux
    
    # Optimize dependencies for better runtime performance
    [profile.dev.package."*"]
    opt-level = 3
    debug = false
    codegen-units = 1  # Faster linking for dependencies

    # Bevy-specific optimizations
    [profile.dev.package.bevy_dylib]
    opt-level = 1  # Keep low for faster linking
    
    [profile.dev.package.bevy_render]
    opt-level = 3  # GPU code needs optimization
    
    [profile.dev.package.bevy_core_pipeline]
    opt-level = 3

    # CI profile - for clean builds in CI
    [profile.ci]
    inherits = "dev"
    incremental = false
    codegen-units = 16

    # WASM development profile
    [profile.wasm-dev]
    inherits = "dev"
    opt-level = "z"  # Optimize for size
    lto = false
    
    [profile.wasm-dev.package."*"]
    opt-level = "z"

    # Fast but debuggable profile
    [profile.fast-dev]
    inherits = "dev"
    opt-level = 2
    debug = 1

    # Release profile
    [profile.release]
    lto = "thin"
    codegen-units = 1
    strip = true
    opt-level = 3
    
    # WASM release profile
    [profile.wasm-release]
    inherits = "release"
    opt-level = "z"  # Optimize for size
    lto = true
    panic = "abort"
  '';

  # Dioxus CLI configuration
  home.file.".config/dioxus/config.toml".text = ''
    [application]
    name = "app"
    default_platform = "web"
    out_dir = "dist"
    asset_dir = "assets"

    [web.app]
    title = "Dioxus App"
    base_path = "/"

    [web.watcher]
    reload_html = true
    watch_path = ["src", "assets"]

    [serve]
    port = 8080
    open = false
  '';

  # Rustfmt configuration
  xdg.configFile."rustfmt/rustfmt.toml".text = ''
    edition = "2021"
    max_width = 100
    imports_granularity = "Crate"
    imports_layout = "Vertical"
    group_imports = "StdExternalCrate"
    reorder_imports = true
    use_field_init_shorthand = true
    use_try_shorthand = true
    match_block_trailing_comma = true
    normalize_comments = true
    wrap_comments = true
    format_code_in_doc_comments = true
    format_strings = false
    format_macro_matchers = true
    format_macro_bodies = true
  '';
}
