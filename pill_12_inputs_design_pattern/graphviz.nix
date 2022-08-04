{ mkDerivation, lib, gdSupport ? true, gd, pkg-config }:
# We made gd and its dependencies optional. If gdSupport is true (by
# default), we will fill buildInputs and thus graphviz will be built
# with gd support, otherwise it won't.

mkDerivation {
  name = "graphviz";
  # The src is also an input but it's pointless to change the source
  # from the caller. For version bumps, in nixpkgs we prefer to write
  # another expression (e.g. because patches are needed or different
  # inputs are needed).
  src = ./graphviz-2.49.3.tar.gz;
  buildInputs =
    if gdSupport
      then [
          pkg-config
          (lib.getLib gd)
          (lib.getDev gd)
        ]
      else [];
}

# let
#   pkgs = import <nixpkgs> {};
#   mkDerivation = import ./autotools.nix pkgs;
# in mkDerivation {
#   name = "graphviz";
#   src = ./graphviz-2.49.3.tar.gz;
#   # # the use of the with expression in buildInputs is to avoid
#   # # repeating pkgs:
#   # buildInputs = with pkgs; [
#   #   pkg-config
#   #   (pkgs.lib.getLib gd)
#   #   (pkgs.lib.getDev gd)
#   # ];
# }


