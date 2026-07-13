class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  url "https://github.com/olegshirko/anvil/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "1964647b913b29120cfa5ebc8c54c62308036e8e0d3b8bbf4465eb63a47677ff"
  license "Apache-2.0"

  head "https://github.com/olegshirko/anvil.git", branch: "main"

  depends_on "swift" => :build

  def install
    system "swift", "build", "-c", "release"
    system "codesign", "--entitlements", "entitlements.plist",
           "--force", "-s", "-",
           "--identifier", "com.olegshirko.vz-runner",
           ".build/release/vz-runner"
    bin.install ".build/release/vz-runner"
  end

  test do
    system "#{bin}/vz-runner", "-h"
  end
end
