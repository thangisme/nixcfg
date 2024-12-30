let
  thang = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZ7KokkDS4XU9M15R3htHbt4ZJ9NQeYxVbKWinbE3n5";
in
{
  "warp_priv_key.age".publicKeys = [ thang ];
}
