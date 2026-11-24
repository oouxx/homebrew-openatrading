cask "openatrading" do
  version "0.20.2"

  if Hardware::CPU.intel?
    url "https://github.com/oouxx/homebrew-openatrading/releases/download/v#{version}/openatrading_#{version}_x64.dmg"
    sha256 "0d7180cda030943769b0df83fb9385b7d8d40cdb6d2ba780b7fde68ef9d79950"
  else
    url "https://github.com/oouxx/homebrew-openatrading/releases/download/v#{version}/openatrading_#{version}_aarch64.dmg"
    sha256 "e71ef7679b02064fd4f53e56c8dff99851040dfe7745f1cf547aa91bbf890101"
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
