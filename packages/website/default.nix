{ stdenv, writeScript }:

stdenv.mkDerivation rec {
  name = "website-0.0.1";

  src = ./src;
  builder = writeScript "builder.sh"
    ''
      source $stdenv/setup

      mkdir -p $out
      cp -R $src/* $out
    '';

  meta = {
    description = "A static website.";
    homepage = http://example.com;
    license = stdenv.lib.licenses.mit;
  };
}
