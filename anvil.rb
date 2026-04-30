class Anvil < Formula
  desc "CLI tool that provides container runtimes on macOS and Linux"
  homepage "https://github.com/olegshirko/anvil"
  url "https://github.com/olegshirko/anvil/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "fbebf1b7c3b48e0c5070daabd6e0c8a5c030460dc246558c8ac63e530220a24f"
  license "MIT"
  head "https://github.com/olegshirko/anvil.git", branch: "main"

  depends_on "go" => :build
  depends_on "lima"
  depends_on "qemu"

  def install
    ldflags = %W[
      -s -w
      -X anvil/internal/usecase.appVersion=#{version}
    ]

    if build.head?
      ldflags << "-X anvil/internal/usecase.revision=#{Utils.git_short_head}"
    else
      ldflags << "-X anvil/internal/usecase.revision=a2e2d8bc1194d09c6a9228c11651fc5bcf5a3bb9"
    end

    system "go", "build", *std_go_args(ldflags:), "./cmd/anvil"

    if OS.mac?
      system "codesign", "-s", "-", "--force", bin/"anvil"
    end
  end

  test do
    system "#{bin}/anvil", "version"
  end
end
