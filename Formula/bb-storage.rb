class BbStorage < Formula
  desc "BuildBarnStorage Daemon"
  homepage "https://github.com/buildbarn/bb-storage"
  url "https://github.com/buildbarn/bb-storage.git",
      revision: "51e1a67922e22d65445f43aa809636cb481644f3"
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
      //cmd/bb_storage:bb_storage
    ]
    system Formula["bazelisk"].opt_bin/"bazelisk", "build", *bazel_args, *targets

    bin.install %w[
      bazel-bin/cmd/bb_storage/bb_storage_/bb_storage
    ]

    (etc/"bb_storage").mkpath
    (var/"bb_storage/storage-cas/").mkpath
    (var/"bb_storage/storage-cas/blocks").mkpath
    (var/"bb_storage/storage-cas/persistent_state").mkpath
    (etc/"bb_storage/config.jsonnet").write default_config unless (etc/"bb_storage/config.jsonnet").exist?
  end

  def default_config
    <<~EOS
    {
      contentAddressableStorage: {
        backend: {
          'local': {
            keyLocationMapOnBlockDevice: {
              file: {
                path: '#{var}/bb_storage/storage-cas/key_location_map',
                sizeBytes: 16 * 1024 * 1024,
              },
            },
            keyLocationMapMaximumGetAttempts: 16,
            keyLocationMapMaximumPutAttempts: 64,
            oldBlocks: 8,
            currentBlocks: 24,
            newBlocks: 3,
            blocksOnBlockDevice: {
              source: {
                file: {
                  path: '#{var}/bb_storage/storage-cas/blocks',
                  sizeBytes: 10 * 1024 * 1024 * 1024,
                },
              },
              spareBlocks: 3,
            },
            persistent: {
              stateDirectoryPath: '#{var}/bb_storage/storage-cas/persistent_state',
              minimumEpochInterval: '300s',
            },
          },
        },
        getAuthorizer: { allow: {} },
        putAuthorizer: { allow: {} },
        findMissingAuthorizer: { allow: {} },
      },
      actionCache: {
        backend: {
          completenessChecking: {
            backend: {
              'local': {
                keyLocationMapOnBlockDevice: {
                  file: {
                    path: '#{var}/bb_storage/storage-ac/key_location_map',
                    sizeBytes: 1024 * 1024,
                  },
                },
                keyLocationMapMaximumGetAttempts: 16,
                keyLocationMapMaximumPutAttempts: 64,
                oldBlocks: 8,
                currentBlocks: 24,
                newBlocks: 1,
                blocksOnBlockDevice: {
                  source: {
                    file: {
                      path: '#{var}/bb_storage/storage-ac/blocks',
                      sizeBytes: 100 * 1024 * 1024,
                    },
                  },
                  spareBlocks: 3,
                },
                persistent: {
                  stateDirectoryPath: '#{var}/bb_storage/storage-ac/persistent_state',
                  minimumEpochInterval: '300s',
                },
              },
            },
            maximumTotalTreeSizeBytes: 16 * 1024 * 1024,
          },
        },
        getAuthorizer: { allow: {} },
        putAuthorizer: { instanceNamePrefix: {
          allowedInstanceNamePrefixes: ['foo'],
        } },
      },
      global: { diagnosticsHttpServer: {
        httpServers: [{
          listenAddresses: [':9980'],
          authenticationPolicy: { allow: {} },
        }],
        enablePrometheus: true,
        enablePprof: true,
      } },
      grpcServers: [{
        listenAddresses: [':8980'],
        authenticationPolicy: { allow: {} },
      }],
      schedulers: {
        bar: { endpoint: { address: 'bar-scheduler:8981' } },
      },
      executeAuthorizer: { allow: {} },
      maximumMessageSizeBytes: 16 * 1024 * 1024,
    }
    EOS
  end

  service do
    run [opt_bin/"bb_storage", "--config", etc/"bb_storage/config.jsonnet"]
    keep_alive true
    working_dir var/"bb_storage"
    log_path var/"log/bb_storage.log"
    error_log_path var/"log/bb_storage_errors.log"
  end

  def caveats
    <<~EOS
      Configuration file: #{etc}/bb_storage/config.jsonnet

      To start the service:
        brew services start bb_storage
    EOS
  end
end
