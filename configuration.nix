{ config, pkgs, ... }:

let custompkgs =
  import ./packages/packages.nix { system = pkgs.system; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/kibana.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda";

  networking.hostName = "nixos";
  networking.firewall.allowedTCPPorts =
    [ 80    # http
      443   # https
      5601  # kibana
    ];

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
        custompkgs.rmate
      ];

  programs.zsh.enable = true;

  nixpkgs.config.packageOverrides = pkgs : {
    elasticsearch = custompkgs.elasticsearch;
  };


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

    elasticsearch = {
      enable = true;
      # FIXME: This option is already on master, but is not present in 15.09
      # package = custompkgs.elasticsearch;
      dataDir = "/data/elasticsearch";
    };

    kibana = {
      enable = true;
      package = custompkgs.kibana;
      host = "0.0.0.0";
      dataDir = "/data/kibana";
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
