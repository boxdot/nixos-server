{ stdenv, lib, bundlerEnv, ruby, darwin }:

bundlerEnv {

  # FIXME: Package cannot be installed due to conflict of Gemfiles. 
  # https://github.com/NixOS/nixpkgs/issues/10177

  name = "ruby-project-0.0.0";

  inherit ruby;
  gemfile = ./Gemfile;
  lockfile = ./Gemfile.lock;
  gemset = ./gemset.nix;

  gemConfig = {
    json = attrs: {
      buildInputs = lib.optional stdenv.isDarwin darwin.libobjc;
    };
  };

  meta = with lib; {
    description = "A simple 'Hello, World!' ruby project.";
    license     = licenses.mit;
    platforms   = platforms.unix;
  };
}
