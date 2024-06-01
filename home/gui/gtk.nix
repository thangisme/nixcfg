{ config, ... }: {
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      accent = "lavender";
      flavor = "mocha";
      gnomeShellTheme = true;
      icon = {
        enable = true;
        accent = "lavender";
        flavor = "mocha";
      };
      cursor = {
        enable = true;
        accent = "lavender";
        flavor = "mocha";
      };
    };
  };
}
