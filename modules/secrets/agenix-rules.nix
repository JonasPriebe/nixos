let
  nixbox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIORoRhSUcWKsqj/5H6hRU+ycPHj9bLRmSq9b3AmTqzhL";
  nixtop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINY/ygow2tk6wfhIVvxV02lk07ZTYdTYg0Tku3QV8o7P";
  vps = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOx5Ew4xuhXEWk+EZ/dWjhLGSSV0EzC+g52B84xmuoUJ";
  users = [
    nixbox
    nixtop
  ];
in
{
  "nixtop-wireguard.age".publicKeys = [
    nixtop
  ];
  "nixbox-wireguard.age".publicKeys = [
    nixbox
  ];
  "samba-creds.age".publicKeys = users;
}
