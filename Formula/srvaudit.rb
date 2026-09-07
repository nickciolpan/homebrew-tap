class Srvaudit < Formula
  desc "Terminal audit dashboard for a remote Linux server over one SSH connection"
  homepage "https://github.com/nickciolpan/srvaudit"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/nickciolpan/srvaudit/releases/download/v0.1.0/srvaudit-darwin-arm64.tar.gz"
      sha256 "5b3245d4e1ffcb2ae10836e8ca22a781d4ff130074ba1e4361d99e0d4785a271"

      def install
        bin.install "srvaudit-darwin-arm64" => "srvaudit"
      end
    end

    on_intel do
      url "https://github.com/nickciolpan/srvaudit/releases/download/v0.1.0/srvaudit-darwin-amd64.tar.gz"
      sha256 "c03e98c484697af581b56d73b3fe467dc264ad1fd122e3273e2926ca9c8b3c8a"

      def install
        bin.install "srvaudit-darwin-amd64" => "srvaudit"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nickciolpan/srvaudit/releases/download/v0.1.0/srvaudit-linux-arm64.tar.gz"
      sha256 "b49978fd7fc4072478330ae19bcf66ef9ef1666a59985b0a94f33fd3f51bb9ac"

      def install
        bin.install "srvaudit-linux-arm64" => "srvaudit"
      end
    end

    on_intel do
      url "https://github.com/nickciolpan/srvaudit/releases/download/v0.1.0/srvaudit-linux-amd64.tar.gz"
      sha256 "c0f4c0399d7117bafe2e140ced64bda03af014d99d74cfc5ec7e5e5f6f0394d2"

      def install
        bin.install "srvaudit-linux-amd64" => "srvaudit"
      end
    end
  end

  test do
    assert_match "srvaudit 0.1.0", shell_output("#{bin}/srvaudit --version")
    # No target and no --from-json: the CLI must refuse rather than hang.
    assert_match "TARGET", shell_output("#{bin}/srvaudit 2>&1", 2)
  end
end
