class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.25"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.25/anvil-darwin-arm64.tar.gz"
  sha256 "8d96dc83d3896d55901afd3b20df515bce1c00be6ce21e2fb2ea4e22fb70b649"

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
