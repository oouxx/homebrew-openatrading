cask "openatrading" do
  version "0.12.7"
  sha256 :no_check

  if Hardware::CPU.intel?
    url "https://github.com/oouxx/homebrew-openatrading/releases/download/v#{version}/openatrading_#{version}_x64.dmg"
  else
    url "https://github.com/oouxx/homebrew-openatrading/releases/download/v#{version}/openatrading_#{version}_aarch64.dmg"
  end

  name "OpenATrading"
  desc "AI-native A股短线交易决策工作台"
  homepage "https://github.com/oouxx/homebrew-openatrading"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true

  app "OpenATrading.app"

  zap trash: [
    "~/Library/Application Support/com.openatrading.desktop",
    "~/Library/Caches/com.openatrading.desktop",
    "~/Library/Preferences/com.openatrading.desktop.plist",
    "~/Library/Saved Application State/com.openatrading.desktop.savedState",
    "~/Library/WebKit/com.openatrading.desktop",
  ]
end
