{ config, ... } : {
  qt = {
    enable = true;
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
