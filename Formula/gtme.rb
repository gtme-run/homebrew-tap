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
      url "https://github.com/gtme-run/gtme/releases/download/v0.7.0/gtme_v0.7.0_darwin_arm64.tar.gz"
      sha256 "69a62f7da19343712e8cc148f3960e4e9452cfe1e041e11ac7e502fddc339e36"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.7.0/gtme_v0.7.0_darwin_amd64.tar.gz"
      sha256 "f717af75d736c62a1a306d31199ef704287ca84dffcbebc893cc9e890da61285"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gtme-run/gtme/releases/download/v0.7.0/gtme_v0.7.0_linux_arm64.tar.gz"
      sha256 "d88adf02b3491042556c20bc37f9003e7ff433236545e610ac8afdb17d09a4c8"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.7.0/gtme_v0.7.0_linux_amd64.tar.gz"
      sha256 "03110edf7a1e863df99abc3623e2323eb004f54096db907f5490418057a3b6d9"
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
