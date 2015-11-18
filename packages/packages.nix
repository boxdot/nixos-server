{ system ? builtins.currentSystem }:

let
  pkgs = import <nixpkgs> { inherit system; };
in
rec {

  # our packages

  website = pkgs.callPackage ./website { };

  dotfiles = pkgs.callPackage ./dotfiles { };

  # custom packages

  rmate = pkgs.callPackage ./rmate { };

  elasticsearch = pkgs.callPackage ./elasticsearch { };

  kibana = pkgs.callPackage ./kibana { };

  passenger = pkgs.callPackage ./passenger { };

  nginx = pkgs.callPackage ./nginx {
    rtmp        = true;
    fullWebDAV  = true;
    syslog      = false; # the patch is not found
    moreheaders = true;
    passenger   = true;
  };

}
