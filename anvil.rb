class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.24"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.24/anvil-darwin-arm64.tar.gz"
  sha256 "8868d7068fd9b2f2f8fddab72822cb902f37ad39b7055b94d25973bf8564000e"

  def install
    bin.install "vz-runner-darwin-arm64" => "anvil"
    state_dir = "#{ENV["HOME"]}/.anvil-vz"
    FileUtils.mkdir_p(state_dir)
    FileUtils.cp "vmlinuz-raw", state_dir
    FileUtils.cp "initramfs-containerd", state_dir
  end

  test do
    system "#{bin}/anvil", "-h"
  end
end
