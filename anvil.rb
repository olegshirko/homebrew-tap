class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.26"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.26/anvil-darwin-arm64.tar.gz"
  sha256 "565d1d10f9b8ed6b35440d3b5390ef21244a5f1152e0ba9a5f7178e05dba2182"

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
