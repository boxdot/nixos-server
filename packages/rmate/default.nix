{ stdenv, writeScript, fetchgit }:

stdenv.mkDerivation rec {
  name = "rmate-0.9.6";

  src = fetchgit {
    url = "https://github.com/aurora/rmate.git";
    rev = "2e9f0cc9cbc871de3d261e737e85432fbc3b7251";
    sha256 = "8510348dab23a75424a139e496a5006abb77b5cce48414bc5d7cb409b251448a";
  };

  builder = writeScript "builder.sh"
    ''
      source $stdenv/setup

      mkdir -p $out/bin
      cp $src/rmate $out/bin/
      cp $src/rmate $out/bin/subl
    '';

  meta = {
    description = "Rmate script to use TextMate/Sublime Editor over ssh.";
    license = stdenv.lib.licenses.gpl1;
  };
}
