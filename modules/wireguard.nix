{ config, ... }:
{
  networking = {
    firewall = {
      allowedUDPPorts = [ 2408 ];
    };
    wg-quick.interfaces = {
      cfwarp = {
        address = [
          "172.16.0.2/32"
          "2606:4700:110:8201:bf2e:6489:a721:9545/128"
        ];

        dns = [
          "1.1.1.1"
          "1.0.0.1"
          "2606:4700:4700::1111"
          "2606:4700:4700::1001"
        ];

        privateKeyFile = config.age.secrets.warp_priv_key.path;

        autostart = false;

        peers = [
          {
            publicKey = "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=";

            allowedIPs = [
              "0.0.0.0/0"
              "::/0"
            ];

            endpoint = "162.159.193.9:2408";

            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
