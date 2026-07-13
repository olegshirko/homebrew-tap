class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.3"
  license "Apache-2.0"

  if Hardware::CPU.arm?
    url "https://github.com/olegshirko/anvil/releases/download/v1.0.3/vz-runner-darwin-arm64"
    sha256 "d3927663f4de5b7d8f5bc5497933b550f157a3df91694f36d53d1ada6fffb5c0"
  end

  def install
    bin.install "vz-runner-darwin-arm64" => "anvil"
  end

  test do
    system "#{bin}/anvil", "-h"
  end
end
