class AliceBuildMachine < Formula
  desc "ALICE O2 Build Machine Dependencies via Homebrew"
  homepage "https://alisw.github.io"
  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  version "23.17-1"

  depends_on "alisw/system-deps/o2-full-deps"
  depends_on "mysql"
  depends_on "openjdk"
  depends_on "nomad"
  depends_on "consul"

  def install
    system "touch", "#{prefix}/empty"
  end
end
