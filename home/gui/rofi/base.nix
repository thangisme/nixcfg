{ config, ... } : {
  home.file.".config/rofi/config.rasi".source = ./config.rasi;
}
