class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.23"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.23/anvil-darwin-arm64.tar.gz"
  sha256 "4b064be8d4eed09c479db07107b63d2d08e43c3d7a992ad111437cc00d727756"

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
