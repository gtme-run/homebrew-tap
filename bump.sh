#!/usr/bin/env bash
# Repin Formula/gtme.rb to a released tag of gtme-run/gtme.
#
#   ./bump.sh v0.2.0
#
# Reads that release's checksums.txt (the release workflow publishes it
# beside the tarballs) and rewrites every url/sha256 pair. Review the diff,
# run `brew install --formula Formula/gtme.rb && brew test gtme`, commit.
# No network beyond the one GitHub release.
set -euo pipefail

TAG="${1:?usage: ./bump.sh vX.Y.Z}"
if [[ "${TAG}" != v* ]]
then
  echo "bump.sh: tag must look like v0.2.0" >&2
  exit 1
fi
BASE="https://github.com/gtme-run/gtme/releases/download/${TAG}"
FORMULA="$(cd "$(dirname "$0")" && pwd)/Formula/gtme.rb"

if ! SUMS="$(curl -fsSL "${BASE}/checksums.txt")"
then
  echo "bump.sh: no checksums.txt at ${BASE}" >&2
  exit 1
fi

sha_for() {
  printf '%s\n' "${SUMS}" | awk -v f="gtme_${TAG}_$1.tar.gz" '$2 == f { print $1 }'
}

for target in darwin_arm64 darwin_amd64 linux_arm64 linux_amd64
do
  sha="$(sha_for "${target}")"
  if [[ -z "${sha}" ]]
  then
    echo "bump.sh: checksums.txt has no entry for ${target}" >&2
    exit 1
  fi
  # Replace the url line for this target and the sha256 line that follows it.
  awk -v base="${BASE}" -v tag="${TAG}" -v target="${target}" -v sha="${sha}" '
    $1 == "url" && index($2, "_" target ".tar.gz") {
      print "      url \"" base "/gtme_" tag "_" target ".tar.gz\""
      getline
      print "      sha256 \"" sha "\""
      next
    }
    { print }
  ' "${FORMULA}" >"${FORMULA}.tmp" && mv "${FORMULA}.tmp" "${FORMULA}"
done

echo "Formula/gtme.rb now pins ${TAG}:"
grep -n 'url "\|sha256 "' "${FORMULA}"
