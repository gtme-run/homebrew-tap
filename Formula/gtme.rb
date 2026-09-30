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
      url "https://github.com/gtme-run/gtme/releases/download/v0.8.0/gtme_v0.8.0_darwin_arm64.tar.gz"
      sha256 "8552095dd5c73f2d8a437a906e6fecd5a237a433d790ab8a21fc5f180ec76033"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.8.0/gtme_v0.8.0_darwin_amd64.tar.gz"
      sha256 "139c9b3d12a1d01c2046f4a85a9f5385717e6b6d9544b41dbfb09380c4c857d5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gtme-run/gtme/releases/download/v0.8.0/gtme_v0.8.0_linux_arm64.tar.gz"
      sha256 "af41b2816b3e891855c0428809e492367666e28dce79e2d60d9a3115c31ccf19"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.8.0/gtme_v0.8.0_linux_amd64.tar.gz"
      sha256 "ff21b7e5154fb0e9893a6eb1d703c98f481aedc88b1538fea9e7dcfb3bbb8fbb"
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
