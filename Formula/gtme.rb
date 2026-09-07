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
      url "https://github.com/gtme-run/gtme/releases/download/v0.5.0/gtme_v0.5.0_darwin_arm64.tar.gz"
      sha256 "e038556cc8b0d958f5621697ba7a66155967cc8dda0b730fb6559cf84e4dfcb3"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.5.0/gtme_v0.5.0_darwin_amd64.tar.gz"
      sha256 "00eca95503481696672dd7e2e0713b64523a1db12f543b8190847b235893de64"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gtme-run/gtme/releases/download/v0.5.0/gtme_v0.5.0_linux_arm64.tar.gz"
      sha256 "b5cad8a9afb16b579d0687f4a9db00b3a76544087df6b31d740e1bc0bd83d40b"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.5.0/gtme_v0.5.0_linux_amd64.tar.gz"
      sha256 "8d34591d1c8fc521f2267024c925dbfb5c21bed766a224c4be9d860578e3a2ad"
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
