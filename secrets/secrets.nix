let
  thang = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHBJBKQp7sDnkrA4tzX04AYCTsUdmhXwjZhXLVaKv4eP";
in
{
  "warp_priv_key.age".publicKeys = [ thang ];
}
