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
      url "https://github.com/gtme-run/gtme/releases/download/v0.10.1/gtme_v0.10.1_darwin_arm64.tar.gz"
      sha256 "5d66a8c9a094981ce11a05c791ff7b62c0b709bbb190a994f8719f66ad74b1a5"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.10.1/gtme_v0.10.1_darwin_amd64.tar.gz"
      sha256 "33467a8051fc28ad864086dcaed4652cb45060e2c0ed882a72512e64954db126"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gtme-run/gtme/releases/download/v0.10.1/gtme_v0.10.1_linux_arm64.tar.gz"
      sha256 "1f2a4b6e6b1f01218da450ad5739e4061c29e6a0af97f002ab7970a35eeaa590"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.10.1/gtme_v0.10.1_linux_amd64.tar.gz"
      sha256 "052ef0f101ea922b16f49e805ca2c5d529266676d198500a728ddc4212c3c46f"
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
