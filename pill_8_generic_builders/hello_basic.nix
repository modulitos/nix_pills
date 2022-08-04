with (import <nixpkgs> {});
derivation {
  name = "hello";
  builder = "${bash}/bin/bash";
  args = [ ./hello_builder.sh ];
  inherit gnutar gzip gnumake gcc coreutils gawk gnused gnugrep;
  # Darwin (i.e. macOS) builds typically use clang rather than gcc for a C compiler. We can adapt this early example for darwin by using this modified version of hello.nix:
  # gcc = clang;
  # binutils = clang.bintools.bintools_bin;
  bintools = binutils.bintools;
  src = ./hello-2.10.tar.gz;
  system = builtins.currentSystem;
}
