class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.15"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.15/anvil-darwin-arm64.tar.gz"
  sha256 "2bc548bef3f9f0eb0bef5873e90803e9db207a40a620adec9425c0be6020b89b"

  resource "vmlinuz" do
    url "https://github.com/olegshirko/anvil/releases/download/v1.0.15/vmlinuz-raw"
  end

  resource "initramfs" do
    url "https://github.com/olegshirko/anvil/releases/download/v1.0.15/initramfs-containerd"
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
