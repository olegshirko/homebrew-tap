class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.27"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.27/anvil-darwin-arm64.tar.gz"
  sha256 "6be621851ddb36db479c7629070ae95ad4786e8578f46493e557861cc7c94889"

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
