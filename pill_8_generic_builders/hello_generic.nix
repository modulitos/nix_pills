# with (import <nixpkgs> {});
# derivation {
#   name = "hello";
#   builder = "${bash}/bin/bash";
#   args = [ ./builder.sh ];
#   # These derivations can be converted to strings (eg:  > builtins.toString [ gnugrep gnused ] in the nix repl)
#   buildInputs = [ gnutar gzip gnumake gcc coreutils gawk gnused gnugrep binutils.bintools ];
#   src = ./hello-2.10.tar.gz;
#   system = builtins.currentSystem;
# }

# rewritten to use autotools.nix function:
# let
#   pkgs = (import <nixpkgs> {});
#   mkDerivation = (import ./autotools.nix pkgs);
# in mkDerivation {
#   src = ./hello-2.10.tar.gz;
#   name = "hello_generic";
# }
let
  pkgs = import <nixpkgs> {};
  mkDerivation = import ./autotools.nix pkgs;
in mkDerivation {
  name = "hello";
  src = ./hello-2.10.tar.gz;
}
