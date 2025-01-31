{
  inputs,
  system,
  ...
}:
{
  age.identityPaths = [ "/var/key/agenix" ];

  age.secrets = {
    warp_priv_key = {
      file = ../secrets/warp_priv_key.age;
      owner = "thang";
    };
    vaultwarden_env = {
      file = ../secrets/vaultwarden_env.age;
      owner = "thang";
    };
    openwebui_env = {
      file = ../secrets/openwebui_env.age;
      owner = "thang";
    };
  };
}
