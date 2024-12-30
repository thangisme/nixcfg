{ inputs, ... }:
{
  environment.systemPackages = [ inputs.agenix.packages.x86_64-linux.default ];

  age.identityPaths = [ "/home/thang/.ssh/id_ed25519" ];

  age.secrets = {
    warp_priv_key = {
      file = ../secrets/warp_priv_key.age;
      owner = "thang";
    };
  };
}
