class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.16"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.16/anvil-darwin-arm64.tar.gz"
  sha256 "c80670e0323cc9386db823c07d2659aab63fcd92f7181f59c3f2cdd270832f4d"

  resource "vmlinuz" do
    url "https://github.com/olegshirko/anvil/releases/download/v1.0.16/vmlinuz-raw"
  end

  resource "initramfs" do
    url "https://github.com/olegshirko/anvil/releases/download/v1.0.16/initramfs-containerd"
  end

  def install
    bin.install "vz-runner-darwin-arm64" => "anvil"
    state_dir = "#{ENV["HOME"]}/.anvil-vz"
    resource("vmlinuz").stage do
      FileUtils.mkdir_p(state_dir)
      FileUtils.cp "vmlinuz-raw", state_dir
    end
    resource("initramfs").stage do
      FileUtils.mkdir_p(state_dir)
      FileUtils.cp "initramfs-containerd", state_dir
    end
  end

  test do
    system "#{bin}/anvil", "-h"
  end
end
