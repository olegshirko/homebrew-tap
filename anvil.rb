class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.46/anvil-darwin-arm64.tar.gz"
  version "1.0.46"
  sha256 "c35224bfbc934c2f0eeb7ffb91ae6b147135adc192e2987a2f7a95ea0086d625"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on :macos










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
