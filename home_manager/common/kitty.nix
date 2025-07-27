{ config, lib, pkgs, ... }:
let
  kittyPackage = pkgs.kitty.overrideAttrs (oldAttrs: {
    preFixup = (oldAttrs.preFixup or "") + ''
      # Remove bash integration script to prevent the warning
      rm -f $out/lib/kitty/shell-integration/bash/kitty.bash
      # Create a dummy file so kitty doesn't complain
      mkdir -p $out/lib/kitty/shell-integration/bash
      echo "# Disabled" > $out/lib/kitty/shell-integration/bash/kitty.bash
    '';
  });
in
{
  home.packages = with pkgs; [
    jetbrains-mono
    # Use the new nerd-fonts structure
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];
  programs.kitty = lib.mkForce {
    enable = true;
    package = kittyPackage;
    settings = {
      shell = "${pkgs.zsh}/bin/zsh";
      shell_integration = "disabled";
      linux_display_server = "auto";
      update_check_interval = 0;
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      window_padding_width = 10;
      background_opacity = "0.8";
      background_blur = 5;
      font_family = "JetBrains Mono";
      bold_font = "JetBrains Mono Bold";
      italic_font = "JetBrains Mono Italic";
      bold_italic_font = "JetBrains Mono Bold Italic";
      font_size = 11;
      symbol_map =
        let
          mappings = [
            "U+23FB-U+23FE"
            "U+2B58"
            "U+E200-U+E2A9"
            "U+E0A0-U+E0A3"
            "U+E0B0-U+E0BF"
            "U+E0C0-U+E0C8"
            "U+E0CC-U+E0CF"
            "U+E0D0-U+E0D2"
            "U+E0D4"
            "U+E700-U+E7C5"
            "U+F000-U+F2E0"
            "U+2665"
            "U+26A1"
            "U+F400-U+F4A8"
            "U+F67C"
            "U+E000-U+E00A"
            "U+F300-U+F313"
            "U+E5FA-U+E62B"
          ];
        in
        (builtins.concatStringsSep "," mappings) + " JetBrainsMono Nerd Font";
    };
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+q" = "close_tab";
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+l" = "next_layout";
    };
  };
}
