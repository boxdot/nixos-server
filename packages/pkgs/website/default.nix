{ stdenv }:

stdenv.mkDerivation rec {
  name = "website-0.0.1";

  src = ../../website;
  builder = ./builder.sh;

  meta = {
    description = "A static website.";
    homepage = http://example.com;
    license = stdenv.lib.licenses.mit;
  };
}
