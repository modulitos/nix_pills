# we have an import function call nested in a with statement. Recall that import accepts one argument, a nix file to load. In this case, the contents of the file evaluated to a function.
#
# import <nixpkgs> {} is calling two functions, not one. Reading it as (import <nixpkgs>) {} makes this clearer.
#
# The value returned by the nixpkgs function is a set. More specifically, it's a set of derivations. Using the with expression we bring them into scope. This is equivalent to the :l <nixpkgs> we used in nix repl; it allows us to easily access derivations such as bash, gcc, and coreutils
with (import <nixpkgs> {});

derivation {
  name = "simple";
  builder = "${bash}/bin/bash";
  args = [ ./simple_builder.sh ];
  # inherit foo; is equivalent to foo = foo;. Similarly, inherit foo bar; is equivalent to foo = foo; bar = bar;.
  # (This syntax only makes sense inside sets. There's no magic involved, it's simply a convenience to avoid repeating the same name for both the attribute name and the value in scope.)
  inherit gcc coreutils;
  src = ./simple.c;
  system = builtins.currentSystem;
}

