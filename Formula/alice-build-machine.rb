class O2FullDeps < Formula
  desc "ALICE O2 Build Machine Dependencies via Homebrew"
  homepage "https://alisw.github.io"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version "20.3-1"

  depends_on "alisw/system-deps/o2-full-deps"
  depends_on "mysql"
  depends_on "openjdk"

  def install
    system "touch", "#{prefix}/empty"
  end
end
