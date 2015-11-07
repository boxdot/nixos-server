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
      config = ''

      worker_processes  1;

      error_log  logs/error.log;
      pid        logs/nginx.pid;


      events {
          worker_connections  1024;
      }


      http {
          # include       mime.types;
          # default_type  application/octet-stream;

          log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                           '$status $body_bytes_sent "$http_referer" '
                           '"$http_user_agent" "$http_x_forwarded_for"';

          access_log  logs/access.log  main;

          sendfile        on;
          #tcp_nopush     on;

          #keepalive_timeout  0;
          keepalive_timeout  65;

          gzip  on;

          server {
              listen       80;
              # server_name  localhost;

              # access_log  logs/host.access.log  main;

              root   ${custompkgs.website};
              index  index.html index.htm;

              location / {
              }

              #error_page  404              /404.html;

              # redirect server error pages to the static page /50x.html
              #
              error_page   500 502 503 504  /50x.html;
              location = /50x.html {
                  root   ${pkgs.nginx}/html;
              }
          }
      }

      '';
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


  # The NixOS release to be compatible with for stateful data such as databases.

  system.stateVersion = "15.09";

}
