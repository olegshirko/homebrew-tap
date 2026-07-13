class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  version "1.0.1"
  license "Apache-2.0"

  if Hardware::CPU.arm?
    url "https://github.com/olegshirko/anvil/releases/download/v1.0.1/vz-runner-darwin-arm64"
    sha256 "5e7da77240adff5871feb467e4623587d47c5033c0dbec5e0790998b0ab056f8"
  end

  def install
    bin.install "vz-runner-darwin-arm64" => "vz-runner"
  end

  test do
    system "#{bin}/vz-runner", "-h"
  end
end
