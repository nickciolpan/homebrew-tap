class Srvaudit < Formula
  desc "Terminal audit dashboard for a remote Linux server over one SSH connection"
  homepage "https://github.com/nickciolpan/srvaudit"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/nickciolpan/srvaudit/releases/download/v0.1.2/srvaudit-darwin-arm64.tar.gz"
      sha256 "64bb32cea316ec7f38cf45d73e19fdb04cb85cc5ef74eec5fe2e90c50c4427d1"
    end

    on_intel do
      url "https://github.com/nickciolpan/srvaudit/releases/download/v0.1.2/srvaudit-darwin-amd64.tar.gz"
      sha256 "906aefff590bc3485cc0d9eee3a71c9b868a8aa25795e615687645ab44810831"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nickciolpan/srvaudit/releases/download/v0.1.2/srvaudit-linux-arm64.tar.gz"
      sha256 "ea1ddd11f23d19465da537692ca17b9a7efcb0721438c46ddf23d406dad8dcd6"
    end

    on_intel do
      url "https://github.com/nickciolpan/srvaudit/releases/download/v0.1.2/srvaudit-linux-amd64.tar.gz"
      sha256 "d3ca54b029701de41d7944b5b7ca073f2de21e0aaa625473fb47034e702e0aed"
    end
  end

  # Each tarball holds exactly one file: the platform-named binary.
  def install
    bin.install Dir["srvaudit-*"].first => "srvaudit"
  end

  test do
    assert_match "srvaudit #{version}", shell_output("#{bin}/srvaudit --version")

    # With no target and no --from-json, the CLI must refuse rather than hang.
    assert_match "TARGET", shell_output("#{bin}/srvaudit 2>&1", 2)

    # Rendering a saved audit needs neither network nor ssh.
    (testpath/"audit.json").write '{"target":"web-01"}'
    report = shell_output("#{bin}/srvaudit --from-json #{testpath}/audit.json --report text")
    assert_match "Server audit", report
  end
end
