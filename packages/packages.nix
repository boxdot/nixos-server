{ system ? builtins.currentSystem }:

let
  pkgs = import <nixpkgs> { inherit system; };
in
rec {

  # our packages

  website = pkgs.callPackage ./pkgs/website { };

  dotfiles = pkgs.callPackage ./pkgs/dotfiles { };

}
