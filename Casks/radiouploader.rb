cask "radiouploader" do
  arch arm: "-arm64"

  version "1.0.0"
  sha256 arm:   "47ab01ef28151f3b7eee9dbc43f2fbce0692b1d2662829aa061b5be9d06368e9",
         intel: "17e3c742775e835c0a46caf72af5b91d01cafa2b7539f72ac679ceb62525a7e1"

  url "https://github.com/gmadevs/Radiouploader/releases/download/v#{version}/Radiouploader-#{version}#{arch}.dmg",
      verified: "github.com/gmadevs/Radiouploader/"
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
