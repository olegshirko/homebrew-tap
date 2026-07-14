class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.19"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.19/anvil-darwin-arm64.tar.gz"
  sha256 "655407c56b94a7c793af96c7353148aa0428d9a623d7d63a4f8c481e2745bf7b"

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
