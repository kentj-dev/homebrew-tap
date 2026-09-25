class Teks < Formula
  desc "Local SMS testing for developers"
  homepage "https://github.com/kentj-dev/teks"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.0/teks-aarch64-apple-darwin.tar.xz"
      sha256 "0450d37351eb272b533e1308ddde87b4a358636571850cc0cda2bbcab3e39b1f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.0/teks-x86_64-apple-darwin.tar.xz"
      sha256 "bea65e9b1d40b6bd89dcc9d8a1fccaf560719fe7831e4b04741d3c400e33bac9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.0/teks-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9d4d5a6ad0e1a439f35d57dd0bed2bb06a31e863e1032c540bc8205d662272fd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.0/teks-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "13039de90cbe1bd9639347485a9fd5be75df272005736770b05164db4436d15d"
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
