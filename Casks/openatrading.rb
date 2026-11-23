cask "openatrading" do
  version "0.20.0"

  if Hardware::CPU.intel?
    url "https://github.com/oouxx/homebrew-openatrading/releases/download/v#{version}/openatrading_#{version}_x64.dmg"
    sha256 "b9cbb40a9047a3351694d73291d424221f7d02f576a7ddbefaa79bea423b6254"
  else
    url "https://github.com/oouxx/homebrew-openatrading/releases/download/v#{version}/openatrading_#{version}_aarch64.dmg"
    sha256 "abd78c9a8b8fdb61b5ab898e8d432e581c0c56179cd543703735c0eb446553bf"
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

  # 产物为 ad-hoc 签名（无 Apple 公证），brew 下载后带 com.apple.quarantine，
  # Gatekeeper 会拦截首次启动。安装时清除隔离属性，让用户双击即可打开。
  # must_succeed: false —— 清除失败不中断安装。
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/OpenATrading.app"],
        must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/com.openatrading.app",
    "~/Library/Caches/com.openatrading.app",
    "~/Library/Preferences/com.openatrading.app.plist",
    "~/Library/Saved Application State/com.openatrading.app.savedState",
    "~/Library/WebKit/com.openatrading.app",
  ]
end
