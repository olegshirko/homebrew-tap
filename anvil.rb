class Anvil < Formula
  desc "CLI tool that provides container runtimes on macOS and Linux"
  homepage "https://github.com/olegshirko/anvil"
  url "https://github.com/olegshirko/anvil/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "da442f4a1e1a31653737c3f490e43dfa1a962cfee035b82dc25fdd8f4585f938"
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
      ldflags << "-X anvil/internal/usecase.revision=6a7d7dee79a7d0325456d377dcd751b7296290ba"
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
