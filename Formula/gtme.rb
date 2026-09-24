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
      url "https://github.com/gtme-run/gtme/releases/download/v0.6.1/gtme_v0.6.1_darwin_arm64.tar.gz"
      sha256 "e5a9907dc87c5d27f514b68dda4bb22105f92104c63420704de89b48f7c34699"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.6.1/gtme_v0.6.1_darwin_amd64.tar.gz"
      sha256 "e8774a323e5a18edd631535e8421443e7552452f47974103b5d86b4cbc8136d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gtme-run/gtme/releases/download/v0.6.1/gtme_v0.6.1_linux_arm64.tar.gz"
      sha256 "cb85a9fb7ea922df3b30101116c210c6520d32aa763138abd458051583c45f7d"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.6.1/gtme_v0.6.1_linux_amd64.tar.gz"
      sha256 "5d2e4626952adc1f1bbfb52fe47767ad81ac008691d413eccc48b19f19d0b973"
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
