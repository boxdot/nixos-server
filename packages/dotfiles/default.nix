{ stdenv, writeScript }:

stdenv.mkDerivation rec {
  name = "dotfiles";

  src = ./src;
  builder = writeScript "builder.sh"
    ''
      source $stdenv/setup

      mkdir -p $out
      cp -R $src/. $out
    '';

  meta = {
    description = "Dotfiles for users.";
    license = stdenv.lib.licenses.mit;
  };
}
