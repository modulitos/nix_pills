set -e
unset PATH

# for p in $buildInputs; do
for p in $baseInputs $buildInputs; do
  export PATH=$p/bin${PATH:+:}$PATH
done

tar -xf $src

for d in *; do
  if [ -d "$d" ]; then
    cd "$d"
    break
  fi
done

./configure --prefix=$out
make
make install

# That is, for each file we run patchelf --shrink-rpath and strip.
# Note that we used two new commands here, find and patchelf.
# Exercise: These two deserve a place in baseInputs of autotools.nix
# as findutils and patchelf.
#
# https://github.com/NixOS/patchelf
find $out -type f -exec patchelf --shrink-rpath '{}' \; -exec strip '{}' \; 2>/dev/null
