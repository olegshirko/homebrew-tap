class Anvil < Formula
  desc "CLI tool that provides container runtimes on macOS and Linux"
  homepage "https://github.com/olegshirko/anvil"
  url "https://github.com/olegshirko/anvil/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "d90630bc3f0fe75f84884bc631b922caa1fef03edfbcd44f92d882eb8baa9f41"
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
      ldflags << "-X anvil/internal/usecase.revision=0c56851d46bf0a99ae4fed78b25d6172239c48ea"
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
