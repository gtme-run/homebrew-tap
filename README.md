# homebrew-tap

The Homebrew tap for [gtme](https://github.com/elegant-atomics/gtme).

```sh
brew install elegant-atomics/tap/gtme
gtme init
```

The formula installs the prebuilt binary that gtme's release workflow
publishes on every version tag, verified against the `checksums.txt`
published beside it. Nothing is compiled, nothing is fetched from anywhere
but that release, and nothing is piped to a shell. macOS and Linux, arm64
and amd64.

## Bumping to a new release

```sh
./bump.sh v0.2.0
brew install --formula Formula/gtme.rb && brew test gtme
git commit -am "gtme v0.2.0"
```

`bump.sh` reads the release's `checksums.txt` and rewrites every url/sha256
pair in `Formula/gtme.rb`. CI installs and tests the
formula on a clean macOS and a clean Linux runner on every push.
