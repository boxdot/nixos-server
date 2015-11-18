{ stdenv, writeScript, fetchurl, curl, openssl, gzip }:

let
  version = "5.0.21";
in

stdenv.mkDerivation rec {
  name = "passenger-${version}";

  src = fetchurl {
    url = "https://s3.amazonaws.com/phusion-passenger/releases/passenger-${version}.tar.gz";
    sha1 = "ffmaz1f32vya0lrinlisy45pyf9m7d3x";
  };

  buildInputs = [curl openssl gzip];

  builder = writeScript "builder.sh"
    ''
      source $stdenv/setup

      tar zxf $src
      cd passenger*/
      mkdir -p $out
      mv * $out/
    '';

  meta = {
    description = "Phusion Passenger: a fast and robust web server and application server for Ruby, Python and Node.js";
    license = stdenv.lib.licenses.mit;
  };
}
