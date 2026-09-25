class Teks < Formula
  desc "Local SMS testing for developers"
  homepage "https://github.com/kentj-dev/teks"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.1/teks-aarch64-apple-darwin.tar.xz"
      sha256 "0917e8ec0153c50f659a6de422d1acd31f0740229a15645cb0539a9acadaef5e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.1/teks-x86_64-apple-darwin.tar.xz"
      sha256 "45f0510a08de409bccddfdef33f1b362798785a023b1e3f947b5a35247260528"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.1/teks-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bc5dd31ecfb73d73ded4817ddcb574f393bafa8e6297e159970583a57477a4cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kentj-dev/teks/releases/download/v0.1.1/teks-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7d7e3d094f501980b65756cc4d3de05444bab6723d96058b72bc9110c654352a"
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
