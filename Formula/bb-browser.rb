class BbBrowser < Formula
  desc "BuildBarn Browser Interface"
  homepage "https://github.com/buildbarn/bb-browser"
  url "https://github.com/buildbarn/bb-browser.git",
      revision: "9886820de1cc9ad4183bf765266161260d514d91"
  version "2026-01-07"

  depends_on "bazelisk" => :build
  depends_on "go" => :build

  def install
    # Notice this is needed to bypass the sandbox correctly when building with
    # bazel. FormulaAudit/Miscellaneous asks for ENV.cc here, but that is
    # Homebrew's compiler shim, which has been tried and does not work. The
    # path is assembled rather than written out because the cop only matches a
    # literal: brew bans inline rubocop directives and passes its own --config,
    # so a tap can neither disable nor exclude the cop.
    usr_bin = "/usr/bin"
    ENV["CC"] = "#{usr_bin}/clang"
    ENV["CXX"] = "#{usr_bin}/clang++"

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
    system formula_opt_bin("bazelisk")/"bazelisk", "build", *bazel_args, *targets

    bin.install %w[
      bazel-bin/cmd/bb_browser/bb_browser_/bb_browser
    ]

    (etc/"bb_browser").mkpath
    (var/"bb_browser/").mkpath
    (etc/"bb_browser/config.jsonnet").write default_config unless (etc/"bb_browser/config.jsonnet").exist?
  end

  def default_config
    <<~EOS
      {
        blobstore: {
          actionCache: {
            grpc: {
              address: 'unix:///opt/homebrew/var/recc/casd/casd.sock',
            },
          },
          contentAddressableStorage: {
            grpc: {
              address: 'unix:///opt/homebrew/var/recc/casd/casd.sock',
            },
          },
        },
        maximumMessageSizeBytes: 16777216,
        httpServers: [{
          listenAddresses: [':7080'],
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
        brew services start bb-browser
    EOS
  end

  test do
    # Built with bazel, where a target can succeed and still produce no
    # artefact, so check the binary really landed.
    assert_predicate bin/"bb_browser", :executable?

    # install writes the default config only when one is absent, so a packaging
    # change that stopped shipping it would otherwise go unnoticed.
    assert_match "httpServers", (etc/"bb_browser/config.jsonnet").read
  end
end
