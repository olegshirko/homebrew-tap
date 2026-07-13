class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.2"
  license "Apache-2.0"

  if Hardware::CPU.arm?
    url "https://github.com/olegshirko/anvil/releases/download/v1.0.2/vz-runner-darwin-arm64"
    sha256 "193328f95e729e3c7d311bfcfaa9f44547146bc33bb02d397fc137b2067c3654"
  end

  def install
    bin.install "vz-runner-darwin-arm64" => "anvil"
  end

  test do
    system "#{bin}/anvil", "-h"
  end
end
