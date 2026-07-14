class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.14"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.14/anvil-darwin-arm64.tar.gz"
  sha256 "dcbf57f72838a1d31ac79d64558a7818038ffcb1787a709314ad0d234b9d82d8"

  def install
    bin.install "vz-runner-darwin-arm64" => "anvil"
  end

  test do
    system "#{bin}/anvil", "-h"
  end
end
