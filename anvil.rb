class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.5"
  license "Apache-2.0"

  if Hardware::CPU.arm?
    url "https://github.com/olegshirko/anvil/releases/download/v1.0.5/vz-runner-darwin-arm64"
    sha256 "c5c99fe1c9cb4a37e32fde2bfe253138499f5304db4d4b398322bd02d9476815"
  end

  def install
    bin.install "vz-runner-darwin-arm64" => "anvil"
  end

  test do
    system "#{bin}/anvil", "-h"
  end
end
