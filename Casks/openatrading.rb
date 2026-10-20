cask "openatrading" do
  version "0.15.11"

  if Hardware::CPU.intel?
    url "https://github.com/oouxx/homebrew-openatrading/releases/download/v#{version}/openatrading_#{version}_x64.dmg"
    sha256 "a7d128419ef222fc4bb5e77ad57a8ace87782625967d449898c51b03c3012ba7"
  else
    url "https://github.com/oouxx/homebrew-openatrading/releases/download/v#{version}/openatrading_#{version}_aarch64.dmg"
    sha256 "482c05e53c4b3ff1014a485249feb8d9545e4da9ba5d482dfd559e8b9bbf312e"
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
  # must_succeed: false —— 清除失败不中断安装，caveats 里给了手动兜底命令。
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

  caveats <<~EOS
    OpenATrading 为 ad-hoc 签名（未经 Apple 公证），brew 安装时已自动清除隔离属性。
    若你从网页直接下载 DMG 安装，首次打开会被 Gatekeeper 拦截，请先执行：
      xattr -dr com.apple.quarantine /Applications/OpenATrading.app
  EOS
end
