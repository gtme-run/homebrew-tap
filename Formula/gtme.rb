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
      url "https://github.com/gtme-run/gtme/releases/download/v0.10.0/gtme_v0.10.0_darwin_arm64.tar.gz"
      sha256 "e9bacd55ab29d5ebd592ed817de9a487916cc4ac52f3c6ce3956f86aa83766d2"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.10.0/gtme_v0.10.0_darwin_amd64.tar.gz"
      sha256 "ea5c94a5451ae0daf9532383f1fc04513e9fd81963b8133a78bfda3414f5b889"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gtme-run/gtme/releases/download/v0.10.0/gtme_v0.10.0_linux_arm64.tar.gz"
      sha256 "4852bcee683695e248f0f869e714fe4c561c1e4a7d92d1f2ea766ae01250f9fd"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.10.0/gtme_v0.10.0_linux_amd64.tar.gz"
      sha256 "71019717ece06a1335f75954efefc87889aa6054ad1ffa4fcb45ef53b56d8ec1"
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
