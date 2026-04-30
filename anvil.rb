class Anvil < Formula
  desc "CLI tool that provides container runtimes on macOS and Linux"
  homepage "https://github.com/olegshirko/anvil"
  url "https://github.com/olegshirko/anvil/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "d994d4fde0a1a0dd2c48bd5aa05d428bef98a02015fefd34bba74e122e960a99"
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
      ldflags << "-X anvil/internal/usecase.revision=1171393282dc26ec22315c35a2eeb5e34ff6edca"
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
