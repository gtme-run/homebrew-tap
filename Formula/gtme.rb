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
      url "https://github.com/elegant-atomics/gtme/releases/download/v0.2.0/gtme_v0.2.0_darwin_arm64.tar.gz"
      sha256 "a12fe94fcab0d2d7d6a99083dd2da48afaf8bce6fe3887d387c557f1f458c2d6"
    end
    on_intel do
      url "https://github.com/elegant-atomics/gtme/releases/download/v0.2.0/gtme_v0.2.0_darwin_amd64.tar.gz"
      sha256 "b416fafff28589693417d13df7bd9d44cc2c2b8e8b9d81da7f10d5bf5dc60d7d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/elegant-atomics/gtme/releases/download/v0.2.0/gtme_v0.2.0_linux_arm64.tar.gz"
      sha256 "2bcb97704026180f66145eb3696dc2fb5496d2f64904530e422a28824385a687"
    end
    on_intel do
      url "https://github.com/elegant-atomics/gtme/releases/download/v0.2.0/gtme_v0.2.0_linux_amd64.tar.gz"
      sha256 "726756e9e0a887bddae0bd11d354d0a8c5d9ad629a1b0267a6f29604c8584053"
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
