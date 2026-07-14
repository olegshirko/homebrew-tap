class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.9"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.9/vz-runner-darwin-arm64"
  sha256 "73473a86383361cabcb00cec2c32598f6b7a753d428e53c36b2c8f552a2208eb"

  def install
    bin.install "vz-runner-darwin-arm64" => "anvil"
  end

  test do
    system "#{bin}/anvil", "-h"
  end
end
