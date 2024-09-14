{ config, ... }: {
    home.file.".config/rofi" = {
    source = ./.;
    recursive = true;
  };
}
