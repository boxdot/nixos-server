{ stdenv, writeScript }:

stdenv.mkDerivation rec {
  name = "subl";

  src = ./src;
  builder = writeScript "builder.sh"
    ''
      source $stdenv/setup

      mkdir -p $out/bin
      cp $src/subl $out/bin/
    '';

  meta = {
    description = "Subl script to use sublime editor over ssh.";
    license = stdenv.lib.licenses.gpl1;
  };
}
