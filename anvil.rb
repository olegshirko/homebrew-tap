class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.21"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.21/anvil-darwin-arm64.tar.gz"
  sha256 "01c854f30a6a88e60584145be61843ea02b5c3055feb7ef368547698f09a9035"

  def install
    bin.install "vz-runner-darwin-arm64" => "anvil"
    chmod 0755, bin/"anvil"
    state_dir = "#{ENV["HOME"]}/.anvil-vz"
    FileUtils.mkdir_p(state_dir)
    FileUtils.cp "vmlinuz-raw", state_dir
    FileUtils.cp "initramfs-containerd", state_dir
  end

  test do
    system "#{bin}/anvil", "-h"
  end
end
