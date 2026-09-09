cask "radiouploader" do
  arch arm: "-arm64"

  version "1.3.1"
  sha256 arm:   "477cd7e4e370b01fee7fc2c1e287aebad4c81a2a28f1b548e723bbcd4ea0e2af",
         intel: "f52562ec2165baa3892ef7f5751422f39dafeefc746945b85bdca47c34b31ac8"

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
