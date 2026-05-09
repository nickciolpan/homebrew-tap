class Dux < Formula
  desc "Visual Docker debug helper - terminal UI and browser UI in one binary"
  homepage "https://github.com/nickciolpan/dux"
  url "https://github.com/nickciolpan/dux/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "88a258b2903aff1f3ec2017da9e326b80e31620e9527e788a0a45ef209f3dac0"
  license "MIT"
  head "https://github.com/nickciolpan/dux.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  def caveats
    <<~EOS
      dux runs against your local docker CLI in two modes:

        dux               # terminal UI (default)
        dux serve         # browser UI at http://127.0.0.1:7878/dux
        dux catalog       # dump command catalog as JSON

      Documentation: https://github.com/nickciolpan/dux#readme
    EOS
  end

  test do
    assert_match "dux", shell_output("#{bin}/dux --help")
    assert_match "tui", shell_output("#{bin}/dux --help")
    assert_match "serve", shell_output("#{bin}/dux --help")
    assert_match "ps", shell_output("#{bin}/dux catalog")
  end
end
