export PATH="$gnutar/bin:$gcc/bin:$gnumake/bin:$coreutils/bin:$gawk/bin:$gzip/bin:$gnugrep/bin:$gnused/bin:$bintools/bin"

echo "PATH: $PATH"
echo "src: $src"
echo "tar --version: $(tar --version)"

tar -xzf $src
cd hello-2.10
./configure --prefix=$out
make
make install
