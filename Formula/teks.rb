class Teks < Formula
  desc "Local SMS testing for developers"
  homepage "https://github.com/kentj-dev/teks"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.3/teks-aarch64-apple-darwin.tar.xz"
      sha256 "5b2b8f2cc363f2283c6e74341ab3e6ad16bfccd910979bf2c329b3d0c72c11b2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.3/teks-x86_64-apple-darwin.tar.xz"
      sha256 "30178beab5ea0d7f6265257c81c152246cef8d2de9560c70a74b26ca23690052"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.3/teks-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0e5999f5b1ab1d5411dddd1c0c4fa1204f248116e79131ef874707e22381c362"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.3/teks-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4cc55d24ae7a53d44df32054404ab320d2a8fd19df37f9a282d85e4acecf4eb8"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "teks"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "teks"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "teks"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "teks"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
