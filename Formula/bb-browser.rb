class BbBrowser < Formula
  desc "BuildBarn Browser Interface"
  homepage "https://github.com/buildbarn/bb-browser"
  url "https://github.com/buildbarn/bb-browser.git",
      revision: "9886820de1cc9ad4183bf765266161260d514d91"
  version "2026-01-07"

  depends_on "bazelisk" => :build
  depends_on "go" => :build

  def install
    # Notice this is needed to bypass the sandbox correctly
    # when building with bazel
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
      //cmd/bb_browser:bb_browser
    ]
    system Formula["bazelisk"].opt_bin/"bazelisk", "build", *bazel_args, *targets

    bin.install %w[
      bazel-bin/cmd/bb_browser/bb_browser/bb_browser
    ]

    (etc/"bb_browser").mkpath
    (etc/"bb_browser/config.jsonnet").write default_config unless (etc/"bb_browser/config.jsonnet").exist?
  end

  def default_config
    <<~EOS
      {
        blobstore: {
          actionCache: {
            grpc: {
              address: 'bb-storage:8980',
            },
          },
          contentAddressableStorage: {
            grpc: {
              address: 'bb-storage:8980',
            },
          },
        },
        maximumMessageSizeBytes: 16777216,
        httpServers: [{
          listenAddresses: [':80'],
          authenticationPolicy: { allow: {} },
        }],
        authorizer: {
          allow: {},
        },
        requestMetadataLinksJmespathExpression: { expression: '`{}`' },
      }
    EOS
  end

  service do
    run [opt_bin/"bb_browser", etc/"bb_browser/config.jsonnet"]
    keep_alive true
    working_dir var/"bb_browser"
    log_path var/"log/bb_browser.log"
    error_log_path var/"log/bb_browser_errors.log"
  end

  def caveats
    <<~EOS
      Configuration file: #{etc}/bb_browser/config.jsonnet

      To start the service:
        brew services start bb_browser
    EOS
  end
end
