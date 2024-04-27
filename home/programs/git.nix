{ config, ... }: {
  programs.git = {
    enable = true;
    userName = "Quang Thang";
    userEmail = "thang@thangqt.com";
  };
}
