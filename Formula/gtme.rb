# The gtme formula installs the prebuilt, checksummed binary that the
# release workflow in elegant-atomics/gtme publishes on every version tag.
# Nothing is built here and nothing is fetched from anywhere but that
# release; bump.sh repins it to a newer tag.
class Gtme < Formula
  desc "GTM as code: campaign pipelines in YAML over an append-only SQLite ledger"
  homepage "https://github.com/elegant-atomics/gtme"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/elegant-atomics/gtme/releases/download/v0.1.0/gtme_v0.1.0_darwin_arm64.tar.gz"
      sha256 "5f8ecf8d2484b8b9cb9c0638eb1fe8230b601672e4f58f518251f8d0fef1abf3"
    end
    on_intel do
      url "https://github.com/elegant-atomics/gtme/releases/download/v0.1.0/gtme_v0.1.0_darwin_amd64.tar.gz"
      sha256 "3f98cd44fc48329d5b1b2a8d8b4f63c2a63b3297efda80691530f18ced85e679"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/elegant-atomics/gtme/releases/download/v0.1.0/gtme_v0.1.0_linux_arm64.tar.gz"
      sha256 "59fc44eddac9a8b601fee9dac03aff59ba88e7d4ed754658370dff3d0c6b9fad"
    end
    on_intel do
      url "https://github.com/elegant-atomics/gtme/releases/download/v0.1.0/gtme_v0.1.0_linux_amd64.tar.gz"
      sha256 "1165e5577975700e292fb4a17d457d160792beb205ab752b6cdc4ca493085797"
    end
  end

  def install
    bin.install "gtme"
  end

  def caveats
    <<~EOS
      Create ~/.gtme and the ledger, then run a whole campaign offline:
        gtme init
        gtme run examples/demo.yaml --simulate   # from a checkout of the gtme repo

      Get started: https://github.com/elegant-atomics/gtme#get-started
    EOS
  end

  test do
    assert_match "gtme v#{version}", shell_output("#{bin}/gtme version 2>&1")
    system bin/"gtme", "init"
    assert_path_exists testpath/".gtme/ledger.db"
  end
end
