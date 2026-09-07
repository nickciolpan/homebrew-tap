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
      url "https://github.com/nickciolpan/srvaudit/releases/download/v0.1.1/srvaudit-darwin-arm64.tar.gz"
      sha256 "478bd54f85e88996c459beb8b348f4bff2dab520d6c0a2bbf0c9d77b2437e3c4"
    end

    on_intel do
      url "https://github.com/nickciolpan/srvaudit/releases/download/v0.1.1/srvaudit-darwin-amd64.tar.gz"
      sha256 "54366f66ffcc42952159647f0149c128aa61c65b68ed9867c06eb86128aecac3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/nickciolpan/srvaudit/releases/download/v0.1.1/srvaudit-linux-arm64.tar.gz"
      sha256 "c918d542efe8c704d3117beed8a04effd3c9fd5b55f0bd7936630b87ee76954d"
    end

    on_intel do
      url "https://github.com/nickciolpan/srvaudit/releases/download/v0.1.1/srvaudit-linux-amd64.tar.gz"
      sha256 "fffb04dcd300014180f8cd4b7823f8c83cd7f293e651c5e71291b891a071b6f5"
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
