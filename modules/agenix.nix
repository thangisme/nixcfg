{
  inputs,
  system,
  ...
}:
{
  environment.systemPackages = [
    inputs.agenix.packages.${system}.default
  ];

  age.identityPaths = [ "/var/key/agenix" ];

  age.secrets = {
    warp_priv_key = {
      file = ../secrets/warp_priv_key.age;
      owner = "thang";
    };
  };
}
