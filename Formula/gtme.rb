# The gtme formula installs the prebuilt, checksummed binary that the
# release workflow in elegant-atomics/gtme publishes on every version tag.
# Nothing is built here and nothing is fetched from anywhere but that
# release; bump.sh repins it to a newer tag.
class Gtme < Formula
  desc "GTM as code: campaign pipelines in YAML over an append-only SQLite ledger"
  homepage "https://github.com/elegant-atomics/gtme"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/elegant-atomics/gtme/releases/download/v0.3.0/gtme_v0.3.0_darwin_arm64.tar.gz"
      sha256 "406ff2a74ddf70169ceb438d82a84e91617dff3670cbacfa57b6ddde6fcb90bc"
    end
    on_intel do
      url "https://github.com/elegant-atomics/gtme/releases/download/v0.3.0/gtme_v0.3.0_darwin_amd64.tar.gz"
      sha256 "5f9f10f6eecbe1a9bfe8940013b20946d47e250c8dd4f09bbb54f72344a01961"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/elegant-atomics/gtme/releases/download/v0.3.0/gtme_v0.3.0_linux_arm64.tar.gz"
      sha256 "070adcbb2aca6c548a653055f84b3468141e3fab2e779c5dc78bfd74d9eff235"
    end
    on_intel do
      url "https://github.com/elegant-atomics/gtme/releases/download/v0.3.0/gtme_v0.3.0_linux_amd64.tar.gz"
      sha256 "e718739a34a225c6f580a86b0bceb472c03c9f0ed999a99095ea3aa992bf51e7"
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

      Get started: https://github.com/elegant-atomics/gtme#get-started
    EOS
  end

  test do
    assert_match "gtme v#{version}", shell_output("#{bin}/gtme version 2>&1")
    system bin/"gtme", "init"
    assert_path_exists testpath/".gtme/ledger.db"
  end
end
