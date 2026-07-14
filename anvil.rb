class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.28"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.28/anvil-darwin-arm64.tar.gz"
  sha256 "260a9da7a758574c070395b4f1780066b97563b3e601958d47ab9af899c6854c"

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
