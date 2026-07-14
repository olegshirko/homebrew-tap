class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.10"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.10/anvil-darwin-arm64.tar.gz"
  sha256 "80dee8529712bbe662f75f0b4eb4209c14920abfa374dae52e83875ec7a3b613"

  def install
    bin.install "vz-runner-darwin-arm64" => "anvil"
  end

  test do
    system "#{bin}/anvil", "-h"
  end
end
