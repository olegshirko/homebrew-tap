class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.13"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.13/anvil-darwin-arm64.tar.gz"
  sha256 "5029cf709af2cb3062dd89c6aaf1acddae53427c2a7fbc04c89ff29edd05b172"

  def install
    bin.install "vz-runner-darwin-arm64" => "anvil"
  end

  test do
    system "#{bin}/anvil", "-h"
  end
end
