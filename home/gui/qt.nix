{ config, ... } : {
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style = {
      name = "kvantum";
      catppuccin = {
        enable = true;
        accent = "lavender";
        flavor = "mocha";
        apply = true;
      };
    };
  };
}
