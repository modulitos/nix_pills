# from pill 13: https://nixos.org/guides/nix-pills/override-design-pattern.html
rec {
  makeOverridable = f: origArgs:
    let
      origRes = f origArgs;
    in
    origRes // { override = newArgs: makeOverridable f (origArgs // newArgs); };
}

# example repl usage:
#
# $ nix repl
# nix-repl> :l lib.nix
# Added 1 variables.
# nix-repl> f = { a, b }: { result = a+b; }
# nix-repl> f { a = 3; b = 5; }
# { result = 8; }
# nix-repl> res = makeOverridable f { a = 3; b = 5; }
# nix-repl> res
# { override = «lambda»; result = 8; }
# nix-repl> res.override { a = 10; }
# { result = 15; }


# recursive example:
#
# nix-repl> :l lib.nix
# Added 1 variables.
# nix-repl> f = { a, b }: { result = a+b; }
# nix-repl> res = makeOverridable f { a = 3; b = 5; }
# nix-repl> res2 = res.override { a = 10; }
# nix-repl> res2
# { override = «lambda»; result = 15; }
# nix-repl> res2.override { b = 20; }
# { override = «lambda»; result = 30; }



# non-recursive version:
# {
#   makeOverridable = f: origArgs:
#     let
#       origRes = f origArgs;
#     in
#     origRes // { override = newArgs: f (origArgs // newArgs); };
}
