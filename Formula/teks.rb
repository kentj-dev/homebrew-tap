class Teks < Formula
  desc "Local SMS testing for developers"
  homepage "https://github.com/kentj-dev/teks"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.2/teks-aarch64-apple-darwin.tar.xz"
      sha256 "278a6e2ca952f456dda1c95a36b0e236425683d7f94b20495b6e49ac3a0359e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.2/teks-x86_64-apple-darwin.tar.xz"
      sha256 "61ac984bbdd4f028196b591bbdae8f63675f21fcba7cd2bceecf32fa760ddc53"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.2/teks-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3d7d89f9003853b6fa6e3d7b869fcd1a086284d925313a88cf646af19873d8ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.2/teks-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b6c709f7815e72b25f3418173e70c41cb2012665822988c86412a848c7bd2a9e"
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
