class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.22"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.22/anvil-darwin-arm64.tar.gz"
  sha256 "daac4a3c4c93885fe47343eab5e18c37dfdccac374baa753a5b4261668b550f8"

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
