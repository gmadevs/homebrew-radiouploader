cask "radiouploader" do
  arch arm: "-arm64"

  version "1.6.1"
  sha256 arm:   "f66338d0f33a14a7e904d611464d4635ff9d3e0fae6a083b1aef979ab4543b6b",
         intel: "52459c06177dccb255ba96c6f603b52a446dc2ffdefcf749a0c9e6e63d7a6892"

  url "https://github.com/gmadevs/Radiouploader/releases/download/v#{version}/Radiouploader-#{version}#{arch}.dmg"
  name "Radiouploader"
  desc "Prepares DICOM studies and uploads them to Radiopaedia as draft cases"
  homepage "https://github.com/gmadevs/Radiouploader"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Electron 43 sets this in the app itself; a cask that installs on an older
  # macOS installs something that will not start.
  depends_on macos: :monterey

  app "Radiouploader.app"

  # The tokens are in the login keychain, which no cask may empty: remove the
  # "Radiouploader" entry in Keychain Access by hand if you want them gone.
  zap trash: [
    "~/Library/Application Support/Radiouploader",
    "~/Library/Caches/io.github.gmadevs.radiouploader",
    "~/Library/Preferences/io.github.gmadevs.radiouploader.plist",
    "~/Library/Saved Application State/io.github.gmadevs.radiouploader.savedState",
  ]

  caveats <<~EOS
    Radiouploader is not signed with an Apple Developer ID, and Homebrew marks
    what it downloads, so macOS will refuse the first launch. Take the mark off:

      xattr -dr com.apple.quarantine #{appdir}/Radiouploader.app

    Or leave it, let macOS block the app once, and allow it in System Settings ->
    Privacy & Security (on macOS 14 and earlier, Control-click -> Open).

    The app never tells you your images are clean: it looks for burnt-in text
    before anonymising and rings what it finds, but it misses small print and
    text over anatomy. Look at every frame yourself, and read
    https://gmadevs.github.io/Radiouploader/limitations first.
  EOS
end
