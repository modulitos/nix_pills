# pill 13:
let
  nixpkgs = import <nixpkgs> { };
  allPkgs = nixpkgs // pkgs;
  lib = import ./lib.nix;

  callPackage = path:
    let
      f = import path;
      fOverride = lib.makeOverridable f;
      origArgs = (builtins.intersectAttrs (builtins.functionArgs f) allPkgs);
    in
    fOverride origArgs;
  pkgs = with nixpkgs; {
    mkDerivation = import ./autotools.nix nixpkgs;
    hello = callPackage ./hello.nix;
    graphviz = callPackage ./graphviz.nix;
    graphvizCore = (callPackage ./graphviz.nix).override { gdSupport = false; };
  };

  # The original callpackage pattern, without makeOverridable:
  #
  # https://nixos.org/guides/nix-pills/callpackage-design-pattern.html
  # We're defining pkgs in terms of callPackage, and callPackage in
  # terms of pkgs. That magic is possible thanks to lazy evaluation:
  # builtins.intersectAttrs doesn't need to know the values in allPkgs
  # in order to perform intersection, only the keys that do not
  # require callPackage evaluation.
  #
  # callPackage = path: overrides:
  #   let
  #     f = import path;
  #   in
  #   f ((builtins.intersectAttrs (builtins.functionArgs f) allPkgs) // overrides);
  # pkgs = with nixpkgs; {
  #   mkDerivation = import ./autotools.nix nixpkgs;
  #   hello = callPackage ./hello.nix { };
  #   graphviz = callPackage ./graphviz.nix { };
  #   graphvizCore = callPackage ./graphviz.nix { gdSupport = false; };
  # };
in
pkgs

# usage:
# nix-build -A hello
# nix-build default.nix -A hello

# testing graphviz (should fail on graphvizCore, but succeed on graphviz):
# echo 'graph test { a -- b }'|result/bin/dot -Tpng -o test.png


# pill 12:
# https://nixos.org/guides/nix-pills/inputs-design-pattern.html

# let
#   # We bring pkgs into the scope when defining the packages set, which
#   # is very convenient instead of typing "pkgs" in each file.
#   pkgs = import <nixpkgs> { };
#   mkDerivation = import ./autotools.nix pkgs;
# in
# with pkgs; {
#   # The "inherit x" syntax is equivalent to "x = x". So "inherit gd"
#   # here, combined to the above "with pkgs;" is equivalent to "gd =
#   # pkgs.gd".
#   hello = import ./hello.nix { inherit mkDerivation; };
#   graphviz = import ./graphviz.nix { inherit mkDerivation lib gd pkg-config; };
#   graphvizCore = import ./graphviz.nix {
#     inherit mkDerivation lib gd pkg-config;
#     # inherit mkDerivation lib;
#     gdSupport = false;
#   };
# }




# original, without inputs:
#
# {
#   hello = import ../pill_10_nix_shell/hello.nix;
#   graphviz = import ./graphviz.nix;
# }
