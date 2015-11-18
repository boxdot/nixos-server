{ system ? builtins.currentSystem }:

let
  pkgs = import <nixpkgs> { inherit system; };
in
rec {

  # our packages

  website = pkgs.callPackage ./website { };

  ruby-project = pkgs.callPackage ./ruby-project { };

  dotfiles = pkgs.callPackage ./dotfiles { };

  # custom packages

  rmate = pkgs.callPackage ./rmate { };

  elasticsearch = pkgs.callPackage ./elasticsearch { };

  kibana = pkgs.callPackage ./kibana { };

}
