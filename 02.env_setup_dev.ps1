Write-Host "🧰 [1/6] 安裝 Git..." -ForegroundColor Cyan
choco install git -y
if ($?) {
    Write-Host "✅ Git 安裝完成" -ForegroundColor Green
    $env:Path += ';C:\Program Files\Git\cmd'
} else {
    Write-Host "❌ Git 安裝失敗" -ForegroundColor Red
}

Write-Host "`n🔧 設定 Git Alias..." -ForegroundColor Cyan
git config --global alias.ci   commit
git config --global alias.cm   "commit --amend -C HEAD"
git config --global alias.co   checkout
git config --global alias.st   status
git config --global alias.sts  "status -s"
git config --global alias.br   branch
git config --global alias.re   remote
git config --global alias.di   diff
git config --global alias.type "cat-file -t"
git config --global alias.dump "cat-file -p"
git config --global alias.lo   "log --oneline"
git config --global alias.ls   "log --show-signature"
git config --global alias.ll   "log --pretty=format:'%h %ad | %s%d [%Cgreen%an%Creset]' --graph --date=short"
git config --global alias.lg   "log --graph --pretty=format:'%Cred%h%Creset %ad |%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset [%Cgreen%an%Creset]' --abbrev-commit --date=short"
git config --global alias.alias "config --get-regexp ^alias\\."
git config --global alias.ignore "!gi() { curl -sL https://www.gitignore.io/api/\\$@ ;}; gi"
git config --global alias.iac  "!giac() { git init && git add . && git commit -m 'Initial commit' ;}; giac"
git config --global alias.rc  "!grc() { git reset --hard && git clean -fdx ;}; read -p 'Do you want to run the <<< git reset --hard && git clean -fdx >>> command? (Y/N) ' answer && [[ $answer == [Yy] ]] && grc"
Write-Host "✅ Git Alias 設定完成" -ForegroundColor Green

git config --global core.editor "notepad"
Write-Host "✅ Git 預設編輯器設為 notepad" -ForegroundColor Green

Write-Host "`n👤 設定 Git 使用者資訊..." -ForegroundColor Cyan
$userName = Read-Host "請輸入 Git 使用者名稱 (user.name)"
$userEmail = Read-Host "請輸入 Git 使用者 Email (user.email)"
git config --global user.name "$userName"
git config --global user.email "$userEmail"
Write-Host "✅ Git 使用者已設定為 $userName <$userEmail>" -ForegroundColor Green

Write-Host "`n💻 [2/6] 安裝 .NET LTS 版本..." -ForegroundColor Cyan
Invoke-WebRequest https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.ps1 -outfile $env:temp\\dotnet-install.ps1
. $env:temp\\dotnet-install.ps1 -Channel LTS
Write-Host "✅ .NET LTS 安裝完成" -ForegroundColor Green

Write-Host "`n📁 [3/6] 安裝 SetEnv 並更新 PATH..." -ForegroundColor Cyan
Invoke-WebRequest -Uri "https://github.com/doggy8088/SetEnv/releases/download/1.0/SetEnv.exe" -OutFile "$env:temp\\SetEnv.exe"
. $env:temp\\SetEnv.exe -ua PATH %"$env:LOCALAPPDATA\\Microsoft\\dotnet"
Write-Host "✅ PATH 已加入 Microsoft .NET 安裝路徑" -ForegroundColor Green

Write-Host "`n🧰 [4/6] 安裝開發工具 (Python、Node.js、VSCode、TortoiseGit、SourceTree)..." -ForegroundColor Cyan
choco install python312 vscode nodejs-lts tortoisegit sourcetree -y

$env:Path = 'C:\\Program Files\\nodejs;C:\\Program Files\\Microsoft VS Code\\bin;' + $env:Path
Write-Host "✅ 開發工具安裝完成" -ForegroundColor Green

Write-Host "`n📦 安裝全域 NPM 套件..." -ForegroundColor Cyan
npm i -g @angular/cli rimraf json-server lite-server source-map-explorer
Write-Host "✅ NPM 全域工具安裝完成" -ForegroundColor Green

Write-Host "`n🧩 安裝 VSCode 套件..." -ForegroundColor Cyan
code --install-extension ms-vscode.js-debug
code --install-extension esbenp.prettier-vscode # Prettier 是最常用的程式碼格式化工具
code --install-extension doggy8088.git-extension-pack # (Will 保哥)Tr.Doggy 打包的 Git 工具組，包含 GitLens、Git History 等 git UI 工具
code --install-extension johnpapa.vscode-peacock # 可改變 VS Code 工作區的顏色，在多專案/多視窗時幫助你區分。
code --install-extension IBM.output-colorizer # 讓終端機或輸出視窗的文字高亮（彩色 log）。
code --install-extension MS-CEINTL.vscode-language-pack-zh-hant # 把 VS Code 的介面變成繁體中文。
code --install-extension mhutchie.git-graph # 可視化 git 分支與 commit 記錄（像樹狀圖）。
code --install-extension oderwat.indent-rainbow # 縮排階層加上不同顏色，方便看巢狀結構。
code --install-extension ritwickdey.LiveServer # 在本機啟動一個 HTTP server，HTML 網頁可以即時預覽。
code --install-extension yzane.markdown-pdf # 將 Markdown 轉成 PDF、HTML、PNG 等格式。
# code --install-extension doggy8088.angular-extension-pack #  (Will 保哥)Tr.Doggy 打包的 Angular 工具組，包含 Angular Essentials，如 Angular Snippets、Angular Language Service 等 
# code --install-extension nrwl.angular-console # 圖形化執行 Nx 的 Angular 命令
# code --install-extension ms-azuretools.vscode-bicep # 給寫 Azure 基礎建設（IaC）的人用的語言支援插件。
Write-Host "✅ VSCode 套件安裝完成" -ForegroundColor Green

Write-Host "`n🛠️ [5/6] 安裝 PowerShell Core..." -ForegroundColor Cyan
choco install powershell-core -y
if ($?) {
    Write-Host "✅ PowerShell Core 安裝完成" -ForegroundColor Green
} else {
    Write-Host "❌ PowerShell Core 安裝失敗" -ForegroundColor Red
}

Write-Host "`n🛠️ [6/6] 安裝常用 CLI 工具 (OpenSSH, Sysinternals, jq)..." -ForegroundColor Cyan
choco install openssh sysinternals jq -y
if ($?) {
    Write-Host "✅ CLI 工具安裝完成" -ForegroundColor Green
} else {
    Write-Host "❌ CLI 工具安裝失敗" -ForegroundColor Red
}


# =============================
# 📦 安裝 EF Core CLI 工具（dotnet-ef）
# =============================

Write-Host "`n🔧 檢查是否已安裝 dotnet-ef 工具..." -ForegroundColor Cyan

$dotnetEfInstalled = dotnet tool list --global | Select-String "dotnet-ef"

if (-not $dotnetEfInstalled) {
    Write-Host "📦 未偵測到 dotnet-ef，開始安裝中..."
    dotnet tool install --global dotnet-ef
} else {
    Write-Host "✅ 已安裝 dotnet-ef"
    Write-Host "🔎 dotnet-ef 版本：" (dotnet ef --version)
    # 如果你想加強檢查版本，也可以在此比對
    # Write-Host "💡 若需強制更新，請執行：dotnet tool update --global dotnet-ef"
}


Write-Host "`n🎉 開發環境安裝完成！請重新啟動以套用所有 PATH。" -ForegroundColor Yellow
Pause
