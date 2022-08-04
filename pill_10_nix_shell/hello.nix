# activate this with:
# nix-shell hello.nix
#
# then we can step through everything after running "source $setup"
let
  pkgs = import <nixpkgs> {};
  mkDerivation = import ./autotools.nix pkgs;
in mkDerivation {
  name = "hello";
  src = ./hello-2.10.tar.gz;
}
