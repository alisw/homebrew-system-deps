class AliceBuildMachine < Formula
  desc "ALICE O2 Build Machine Dependencies via Homebrew"
  homepage "https://alisw.github.io"
  url "file:///dev/null"
  version "23.48-1"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on "alisw/system-deps/o2-full-deps"
  depends_on "git"
  depends_on "hashicorp/tap/consul"
  depends_on "hashicorp/tap/nomad"
  depends_on "jq" # for build scripts
  depends_on "openjdk"

  def install
    touch "#{prefix}/empty"
  end
end
