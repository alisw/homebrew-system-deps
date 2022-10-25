class O2FullDeps < Formula
  desc "ALICE O2 System Dependencies via Homebrew"
  homepage "https://alisw.github.io"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version "21.06-1"

  depends_on "autoconf"
  depends_on "automake"
  depends_on "cmake"
  depends_on "gcc"
  depends_on "coreutils"
  depends_on "gettext"
  depends_on "texinfo"
  depends_on "glfw3"
  depends_on "gmp"
  depends_on "gsl"
  depends_on "hub"
  depends_on "isl"
  depends_on "libmpc"
  depends_on "libpng"
  depends_on "libtool"
  depends_on "libxml2"
  depends_on "m4"
  depends_on "make"
  depends_on "modules"
  depends_on "mpfr"
  depends_on "msgpack"
  depends_on "perl"
  depends_on "openssl"
  depends_on "pcre"
  depends_on "pkg-config"
  depends_on "readline"
  depends_on "xz"
  depends_on "zeromq"
  depends_on "libomp"
  depends_on "freetype"
  depends_on "pigz"
  depends_on "utf8proc"
  depends_on "libidn2"
  depends_on "gtk-doc"
  depends_on "llvm@13"
  depends_on "clang-format"

  def install
    system "touch", "#{prefix}/empty"
  end
end
