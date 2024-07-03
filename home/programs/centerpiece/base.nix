{ config, ... } : {
    home.file.".config/centerpiece/config.yml".source = ./config.yml;
}
