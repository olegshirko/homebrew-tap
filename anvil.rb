class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.8"
  license "Apache-2.0"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.8/vz-runner-darwin-arm64"
  sha256 "91eeb8fd1c0e861316eb01b48e6ea51fdb1c948d7f8e6f4712fce8923065da8f"

  def install
    bin.install "vz-runner-darwin-arm64" => "anvil"
  end

  test do
    system "#{bin}/anvil", "-h"
  end
end
