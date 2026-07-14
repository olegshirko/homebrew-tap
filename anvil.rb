class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.9"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.9/anvil-darwin-arm64.tar.gz"
  sha256 "bb12f1fcec59ac7c8bef24a4dc06d65f54e80b119e2e7c38cca2f37a03cf043a"

  def install
    bin.install "vz-runner-darwin-arm64" => "anvil"
  end

  test do
    system "#{bin}/anvil", "-h"
  end
end
