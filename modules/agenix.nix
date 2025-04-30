{ hostName, ... }:

{
  age.identityPaths = [ "/var/key/agenix" ];

  age.secrets =
    if hostName == "satellite" then
      {
        openwebui_env = {
          file = ./openwebui_env.age;
          owner = "thang";
        };
      }
    else if hostName == "leaf" then
      {
        vaultwarden_env = {
          file = ./vaultwarden_env.age;
          owner = "thang";
        };
      }
    else
      { };
}
