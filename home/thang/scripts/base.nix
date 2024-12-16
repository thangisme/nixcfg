{ pkgs, ... }:
{
  # home.packages = with pkgs; [
  #   (writeShellScriptBin "notify-pulse" (builtins.readFile ./notify-pulse.sh))
  # ];
  home.file = {
    ".local/bin" = {
      source = ./.;
      recursive = true;
    };
  };
}
