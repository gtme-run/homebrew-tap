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
      url "https://github.com/gtme-run/gtme/releases/download/v0.7.1/gtme_v0.7.1_darwin_arm64.tar.gz"
      sha256 "8e2c00bd2d899006541901d21f93c95c3d28ae5ab75ecae42ca49ddea3c76857"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.7.1/gtme_v0.7.1_darwin_amd64.tar.gz"
      sha256 "34bf8f4ca465fef1c0f7172afef1b1c60555f5514a21da0089c8f700160dc212"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gtme-run/gtme/releases/download/v0.7.1/gtme_v0.7.1_linux_arm64.tar.gz"
      sha256 "073ba468b84e7d816e74c36a38071b8c653503ff4066f0eb58a022e4bb56e402"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.7.1/gtme_v0.7.1_linux_amd64.tar.gz"
      sha256 "f61ed4428d6fb9f4d130f6823bcb338b8b5df1cd1b5ad30cfd8caeb983d0512b"
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
