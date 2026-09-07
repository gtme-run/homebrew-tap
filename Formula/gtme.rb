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
      url "https://github.com/gtme-run/gtme/releases/download/v0.4.0/gtme_v0.4.0_darwin_arm64.tar.gz"
      sha256 "23f7f675d4994c95530005ae21612fc09764f5f1e5460128fcd8c8d841df2a6c"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.4.0/gtme_v0.4.0_darwin_amd64.tar.gz"
      sha256 "76fcc60a19f849c9b059e78c27124be3638792a7fdcdd07a42d2dda8d1d35858"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gtme-run/gtme/releases/download/v0.4.0/gtme_v0.4.0_linux_arm64.tar.gz"
      sha256 "3db3b7973deb7a7b1d6d2b3c4065ffa7faa0336eeeb85974f7a6aeda78cb354d"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.4.0/gtme_v0.4.0_linux_amd64.tar.gz"
      sha256 "ca94afd02dd35c13382b32348768b06f1a6c5a31872a8496c380bf7691c8152a"
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
