{ stdenv, file, writeScript, fetchurl, curl, openssl, gzip, ruby
, libuv, darwin
}:

let
  version = "5.0.21";
in

stdenv.mkDerivation rec {
  name = "passenger-nginx-${version}";

  src = fetchurl {
    url = "https://s3.amazonaws.com/phusion-passenger/releases/passenger-${version}.tar.gz";
    sha1 = "ffmaz1f32vya0lrinlisy45pyf9m7d3x";
  };

  buildInputs = [curl openssl gzip ruby file libuv]
    ++ stdenv.lib.optional stdenv.isDarwin [ darwin.libobjc ];

  enableParallelBuilding = true;

  postUnpack =
  ''
    rm -f passenger*/configure
  '';

  patchPhase = stdenv.lib.optionalString stdenv.isDarwin
  ''
    substituteInPlace src/nginx_module/config --replace stdc++ c++
  '';

  buildPhase =
  ''
    export USE_VENDORED_LIBUV=no
    rake nginx CACHING=false
  '';

  installPhase =
  ''
    ensureDir $out
    cp -r * $out/
  '';

  meta = {
    description = "Phusion Passenger: a fast and robust web server and application server for Ruby, Python and Node.js. With native nginx extension.";
    license = stdenv.lib.licenses.mit;
  };
}
