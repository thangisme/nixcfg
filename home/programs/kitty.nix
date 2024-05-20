{ config, pkgs, ... } : {
    programs.kitty = {
        enable = true;
        theme = "Catppuccin-Mocha";
        font.name = "IosevkaTerm Nerd Font";
        shellIntegration = {
          enableFishIntegration = true;
          mode = "no-cursor";
        };
        extraConfig = ''
          background_opacity 0.95
          window_padding_width 4 8
        '';
    };
}
