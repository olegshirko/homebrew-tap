class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.39/anvil-darwin-arm64.tar.gz"
  version "1.0.39"
  sha256 "653eed6b27ca54941f433c1721f26c97ff31705b5dad464a7354360923e81cf5"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on :macos

  bottle do
    root_url "https://github.com/olegshirko/anvil/releases/download/v1.0.39"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "d5bf7c5c2f9a6b05a6f0f31f1bcc8bede9d55c95626fcc21dc1b3110c26f9ac3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d5bf7c5c2f9a6b05a6f0f31f1bcc8bede9d55c95626fcc21dc1b3110c26f9ac3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "d5bf7c5c2f9a6b05a6f0f31f1bcc8bede9d55c95626fcc21dc1b3110c26f9ac3"
  end



  def install
    bin.install "vz-runner-darwin-arm64" => "vz-runner"
    # Use an absolute target: Homebrew resolves relative symlink sources
    # against bin/, but zerobrew's shim resolves them against the build
    # directory (deleted after install), leaving a dangling symlink.
    bin.install_symlink bin/"vz-runner" => "anvil"

    (share/"anvil/assets").install "initramfs-containerd"
    # Releases >= 1.0.37 ship the kernel gzipped; older ones ship it raw.
    (share/"anvil/assets").install "vmlinuz-raw.gz" if File.exist?("vmlinuz-raw.gz")
    (share/"anvil/assets").install "vmlinuz-raw" if File.exist?("vmlinuz-raw")
    (share/"anvil/scripts").install "anvil-service.sh", "com.olegshirko.anvil.plist"
  end

  service do
    run [opt_prefix/"share/anvil/scripts/anvil-service.sh", "start"]
    require_root false
    log_path var/"log/anvil.log"
    error_log_path var/"log/anvil.log"
    keep_alive false
  end

  def caveats
    <<~EOS
      Anvil needs a persistent disk for containerd state. It will be created
      automatically on the first service start in ~/.anvil-vz/containerd-disk.img.

      Start the service with:
        brew services start anvil

      Or manually (required under zerobrew, which has no services support):
        #{opt_prefix}/share/anvil/scripts/anvil-service.sh start

      Switch Docker context to anvil:
        docker context use anvil
    EOS
  end

  test do
    system "#{bin}/vz-runner", "--help"
  end
end
