class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.7"
  license "Apache-2.0"

  if Hardware::CPU.arm?
    url "https://github.com/olegshirko/anvil/releases/download/v1.0.7/vz-runner-darwin-arm64"
    sha256 "5ba51e74e43a5c84c56d43983b4d6b19908fe7e6140ec02a73f4a46181646513"
  end

  def install
    bin.install "vz-runner-darwin-arm64" => "anvil"
  end

  test do
    system "#{bin}/anvil", "-h"
  end
end
