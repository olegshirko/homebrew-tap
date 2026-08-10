class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.42/anvil-darwin-arm64.tar.gz"
  version "1.0.42"
  sha256 "ac9ba77b01f3c5e823ae1aff6d8bbda66feba3172daad70d5e3df15c20355577"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on :macos

  bottle do
    root_url "https://github.com/olegshirko/anvil/releases/download/v1.0.42"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "5130930b2738c0947d868de9987c1018d55ad41b3ebdc7b2dac1aa6fe2e883c1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5130930b2738c0947d868de9987c1018d55ad41b3ebdc7b2dac1aa6fe2e883c1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "5130930b2738c0947d868de9987c1018d55ad41b3ebdc7b2dac1aa6fe2e883c1"
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
