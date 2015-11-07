{ config, pkgs, ... }:

let custompkgs =
  import ./packages/packages.nix { system = pkgs.system; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda";

  networking.hostName = "nixos";
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  time.timeZone = "Europe/Berlin";


  # Programs

  environment.systemPackages =
    with pkgs;
      [ wget
        vim
        git
        tree

        custompkgs.website
        custompkgs.dotfiles
      ];

  programs.zsh.enable = true;


  # Services

  services = {

    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };

    postgresql = {
      enable = true;
      package = pkgs.postgresql94;
      dataDir = "/data/postgresql";
    };

    nginx = {
      enable = true;
      config = import ./conf/nginx.nix { inherit pkgs custompkgs; };
    };

  };


  # Users

  users.mutableUsers = false;

  users.extraUsers.nixos = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" ];
  };

  users.extraUsers.dima = {
    isNormalUser = true;
    uid = 1001;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [ "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDZ6cQd+3L2dbeB6jEl3lUeiYsxYuN7FO4AQMCz/SpEdBXjKAQlz7L5jUo+4EGux4ziF7pDlVPZpV6WSoW5kmJc= dimw@snow" ];
    shell = "/run/current-system/sw/bin/zsh";
    passwordFile = "/etc/nixos/dima.passwd";
  };

  system.activationScripts.dotfiles =
    ''
      for user in `ls -d ${custompkgs.dotfiles}/*/ | xargs basename`; do
        if [ -e /home/$user ]; then
          for dotfile in `ls -d ${custompkgs.dotfiles}/$user/.*`; do
            if [ -f $dotfile ]; then
              ln -sf $dotfile /home/$user/
            fi
          done
        fi
      done
    '';


  # The NixOS release to be compatible with for stateful data such as databases.

  system.stateVersion = "15.09";

}
