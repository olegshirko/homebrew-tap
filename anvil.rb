class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.13"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.13/anvil-darwin-arm64.tar.gz"
  sha256 "5029cf709af2cb3062dd89c6aaf1acddae53427c2a7fbc04c89ff29edd05b172"

  resource "vmlinuz" do
    url "https://github.com/olegshirko/anvil/releases/download/v1.0.13/vmlinuz-raw"
  end

  resource "initramfs" do
    url "https://github.com/olegshirko/anvil/releases/download/v1.0.13/initramfs-containerd"
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
