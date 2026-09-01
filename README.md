# Radiouploader tap

The Homebrew cask for **[Radiouploader](https://github.com/gmadevs/Radiouploader)** — a
desktop app that prepares a DICOM study and uploads it to
[Radiopaedia.org](https://radiopaedia.org) as a draft case. Unofficial: not affiliated with
or endorsed by Radiopaedia.

```bash
brew install --cask gmadevs/radiouploader/radiouploader
xattr -dr com.apple.quarantine /Applications/Radiouploader.app
```

macOS 12 or later, Apple silicon or Intel. Documentation:
<https://gmadevs.github.io/Radiouploader/>

## The second line

It is not optional. Radiouploader is not signed with an Apple Developer ID, Homebrew marks
what it downloads the way a browser would, and current Homebrew has no `--no-quarantine` to
turn that off — the option was removed. So macOS refuses the first launch of the app
Homebrew has just installed, and `xattr -dr` is what takes the mark off.

The cask does not do that for you. Waiving Gatekeeper on an unsigned binary is a decision
for the person installing it, and one line you type is a decision; a script that strips the
attribute quietly is not.

If you would rather leave the mark in place, skip that line, let macOS block the app once,
and allow it in **System Settings → Privacy & Security** (on macOS 14 and earlier,
Control-click the app and choose **Open**).

## Later, and afterwards

```bash
brew upgrade --cask radiouploader
brew uninstall --cask --zap radiouploader
```

`--zap` also removes what the app left in `~/Library`. It cannot empty the login keychain,
where your Radiopaedia tokens are: sign out in the app first, or delete the *Radiouploader*
entry in Keychain Access.

## Why a tap of its own

`homebrew/cask` asks a project to be notable before it will carry it — thirty days old at
the least, and stars, forks or watchers in numbers this one does not have. A tap needs none
of that from anybody, and `brew install` adds it for you.

## Do not edit the cask here

`Casks/radiouploader.rb` is written by
[a workflow](https://github.com/gmadevs/Radiouploader/blob/main/.github/workflows/cask.yml)
in the app's repository every time a release is published: it hashes the disk images that
release actually published and pushes the result here. **An edit made by hand is overwritten
by the next release.** What the cask says is decided in
[`scripts/cask.mjs`](https://github.com/gmadevs/Radiouploader/blob/main/scripts/cask.mjs),
and anything wrong with it — or with the app — belongs in
[Issues](https://github.com/gmadevs/Radiouploader/issues) over there.
