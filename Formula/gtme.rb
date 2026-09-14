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
      url "https://github.com/gtme-run/gtme/releases/download/v0.6.0/gtme_v0.6.0_darwin_arm64.tar.gz"
      sha256 "b2ebc595a1fd224e44fbcd9ac6f68ab87fb3043c650961ab2dbf884e27ade9a3"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.6.0/gtme_v0.6.0_darwin_amd64.tar.gz"
      sha256 "76d26495ed8ac304a2674a852efb999403b214a5356cff8631986fc53a58c27d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gtme-run/gtme/releases/download/v0.6.0/gtme_v0.6.0_linux_arm64.tar.gz"
      sha256 "39bb7339bbf4529fbd041961a61ea7b023cc257cbe7ffff3928b50b6ec5c9f85"
    end
    on_intel do
      url "https://github.com/gtme-run/gtme/releases/download/v0.6.0/gtme_v0.6.0_linux_amd64.tar.gz"
      sha256 "7a45db696159eca68779c142d840774c50664792e3f8eeee13a7cc0ba2a0a5bb"
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
