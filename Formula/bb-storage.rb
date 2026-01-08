class BbStorage < Formula
  desc "BuildBarnStorage Daemon"
  homepage "https://github.com/buildbarn/bb-storage"
  url "https://github.com/buildbarn/bb-storage.git",
      revision: "51e1a67922e22d65445f43aa809636cb481644f3"
  version "2026-01-07"

  depends_on "bazelisk" => :build
  depends_on "go" => :build

  def install
    ENV["CC"] = "/usr/bin/clang"
    ENV["CXX"] = "/usr/bin/clang++"

    bazel_args = %W[
      --jobs=#{ENV.make_jobs}
      --compilation_mode=opt
      --linkopt=-Wl,-rpath,#{rpath}
      --verbose_failures
      --repo_contents_cache=
    ]
    targets = %w[
      //cmd/bb_storage:bb_storage
    ]
    system Formula["bazelisk"].opt_bin/"bazelisk", "build", *bazel_args, *targets

    bin.install %w[
      bazel-bin/cmd/bb_storage/bb_storage_/bb_storage
    ]

  end
end
