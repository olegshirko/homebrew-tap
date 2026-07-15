class Anvil < Formula
  desc "Lightweight macOS Docker environment using Virtualization.framework"
  homepage "https://github.com/olegshirko/anvil"
  url "https://github.com/olegshirko/anvil/releases/download/v1.0.31/anvil-darwin-arm64.tar.gz"
  sha256 "89646f6230d39010767e40c8a088ea1555df0b1cca61d25d8c676f71b779e61f"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "vz-runner-darwin-arm64" => "vz-runner"
    bin.install_symlink "vz-runner" => "anvil"

    (share/"anvil/assets").install "vmlinuz-raw", "initramfs-containerd"
    (share/"anvil/scripts").install "anvil-service.sh", "com.olegshirko.anvil.plist"
  end

  service do
    run [opt_share/"anvil/scripts/anvil-service.sh", "start"]
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

      Or manually with:
        #{opt_share}/anvil/scripts/anvil-service.sh start

      Switch Docker context to anvil:
        docker context use anvil
    EOS
  end

  test do
    system "#{bin}/vz-runner", "--help"
  end
end
