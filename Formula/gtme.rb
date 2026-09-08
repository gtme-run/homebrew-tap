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
      url "https://github.com/gtme-run/gtme/releases/download/v0.5.1/gtme_v0.5.1_darwin_arm64.tar.gz"
      sha256 "bf8553cdbc536dfde9c0c8d2b7b1ad40051b92a23addf60198d7235c50f4ea40"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.5.1/gtme_v0.5.1_darwin_amd64.tar.gz"
      sha256 "d00564e012d28adb0013dc42e326765a167bde192fd4faf632d556a5eba9e4d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gtme-run/gtme/releases/download/v0.5.1/gtme_v0.5.1_linux_arm64.tar.gz"
      sha256 "a8a46084249cf3562fc4a8a934b5d409cacf471914f97297c2b6116af6921aa1"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.5.1/gtme_v0.5.1_linux_amd64.tar.gz"
      sha256 "a7ee3faeed2237567fa9c11d2a0d906aa8c1a86a8774abc164cc440ea501a9e8"
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
