# The gtme formula installs the prebuilt, checksummed binary that the
# release workflow in gtme-run/gtme publishes on every version tag.
# Nothing is built here and nothing is fetched from anywhere but that
# release; bump.sh repins it to a newer tag.
class Gtme < Formula
  desc "GTM as code: campaign pipelines in YAML over an append-only SQLite ledger"
  homepage "https://github.com/gtme-run/gtme"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/gtme-run/gtme/releases/download/v0.9.0/gtme_v0.9.0_darwin_arm64.tar.gz"
      sha256 "5e2805f52ac2b00b7c2d10ad4e917bfc73a189f53d9689fb2b5c43d25d82e958"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.9.0/gtme_v0.9.0_darwin_amd64.tar.gz"
      sha256 "67f872b768a07fb3de349d1ffde5e601b3f5afb0910d66d7eaf69792412c7cb7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gtme-run/gtme/releases/download/v0.9.0/gtme_v0.9.0_linux_arm64.tar.gz"
      sha256 "e47e0c8a082ac10fe7e7abe9202d47d0aed1d7773362655627dcca3f714fd526"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.9.0/gtme_v0.9.0_linux_amd64.tar.gz"
      sha256 "da4f98607af317a788690ddd3e361dfc67bd4c1d96436327e1cf05f96ca8790f"
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

      Get started: https://github.com/gtme-run/gtme#get-started
    EOS
  end

  test do
    assert_match "gtme v#{version}", shell_output("#{bin}/gtme version 2>&1")
    system bin/"gtme", "init"
    assert_path_exists testpath/".gtme/ledger.db"
  end
end
