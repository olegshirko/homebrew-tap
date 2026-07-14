class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.11"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.11/anvil-darwin-arm64.tar.gz"
  sha256 "85f1b4c0e03d0c763c04c886ba6af1e184e8e576e9222ac5a40948aca03f625d"

  def install
    bin.install "vz-runner-darwin-arm64" => "anvil"
  end

  test do
    system "#{bin}/anvil", "-h"
  end
end
