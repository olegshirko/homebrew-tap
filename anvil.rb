class Anvil < Formula
  desc "CLI tool that provides container runtimes on macOS and Linux"
  homepage "https://github.com/olegshirko/anvil"
  url "https://github.com/olegshirko/anvil/archive/refs/tags/v0.16.0.tar.gz"
  sha256 "21ef2e7bb91581c8dbfa544e830334ab5af57bf22c4473900ca0c8c0881d8628"
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
      ldflags << "-X anvil/internal/usecase.revision=bb2077f88b47be435c2a395724e2a81b8e5c24d0"
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
