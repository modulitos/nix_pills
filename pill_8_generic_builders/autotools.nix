pkgs: attrs:
  # First drop in the scope the magic pkgs attribute set.
  with pkgs;
  # Within a let expression we define a helper variable, defaultAttrs,
  # which serves as a set of common attributes used in derivations
  let defaultAttrs = {
    builder = "${bash}/bin/bash";
    args = [ ./builder.sh ];
    baseInputs = [ gnutar gzip gnumake gcc coreutils gawk gnused gnugrep binutils.bintools ];
    buildInputs = [findutils patchelf ];
    # baseInputs = [ gnutar gzip gnumake gcc coreutils gawk gnused gnugrep binutils.bintools findutils patchelf ];
    # buildInputs = [];
    # buildInputs = [ gnutar gzip gnumake gcc coreutils gawk gnused gnugrep binutils.bintools findutils patchelf ];
    # baseInputs = [];
    system = builtins.currentSystem;
  };
  in
  # Finally we create the derivation with that strange expression,
  # (defaultAttrs // attrs).
  derivation (defaultAttrs // attrs)
