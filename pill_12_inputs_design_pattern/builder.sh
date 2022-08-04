# move the set -e to the builder instead of the setup. The set -e is
# annoying in nix-shell.
set -e
source $setup
genericBuild
