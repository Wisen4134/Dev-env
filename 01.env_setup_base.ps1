Write-Host "📦 [1/5] 安裝 NuGet 套件提供者與信任 PSGallery..." -ForegroundColor Cyan
Install-PackageProvider -Name NuGet -Force
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
if ($?) {
    Write-Host "✅ NuGet 與 PSGallery 設定完成" -ForegroundColor Green
} else {
    Write-Host "❌ NuGet/PSGallery 設定失敗" -ForegroundColor Red
}

Write-Host "🌐 [2/5] 設定顯示語言為 zh-TW..." -ForegroundColor Cyan
$UserLanguageList = New-WinUserLanguageList -Language "en-US"
$UserLanguageList.Add("zh-TW")
Set-WinUserLanguageList -LanguageList $UserLanguageList -Force
Set-WinUILanguageOverride -Language zh-TW
if ($?) {
    Write-Host "✅ 顯示語言設定完成" -ForegroundColor Green
} else {
    Write-Host "❌ 顯示語言設定失敗" -ForegroundColor Red
}

Write-Host "🍫 [3/5] 安裝 Chocolatey..." -ForegroundColor Cyan
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
if ($?) {
    Write-Host "✅ Chocolatey 安裝完成" -ForegroundColor Green
} else {
    Write-Host "❌ Chocolatey 安裝失敗" -ForegroundColor Red
}

Write-Host "⚙️ [4/5] 設定 PowerShell 快捷鍵與個人化檔案..." -ForegroundColor Cyan
[System.IO.Directory]::CreateDirectory([System.IO.Path]::GetDirectoryName($PROFILE))

@'
# 修正 PowerShell 關閉進度列提示
$ProgressPreference = 'SilentlyContinue'

# 使用 TLS 1.2 進行網路安全連線
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# 設定按下 Ctrl+d 可以退出 PowerShell 執行環境
Set-PSReadlineKeyHandler -Chord ctrl+d -Function ViExit

# 設定按下 Ctrl+w 可以刪除一個單字
Set-PSReadlineKeyHandler -Chord ctrl+w -Function BackwardDeleteWord

# 設定按下 Ctrl+e 可以移動游標到最後面(End)
Set-PSReadlineKeyHandler -Chord ctrl+e -Function EndOfLine

# 設定按下 Ctrl+a 可以移動游標到最前面(Begin)
Set-PSReadlineKeyHandler -Chord ctrl+a -Function BeginningOfLine

function hosts { notepad c:\\windows\\system32\\drivers\\etc\\hosts }

# 移除內建的 curl 與 wget 命令別名
If (Test-Path Alias:curl) {Remove-Item Alias:curl}
If (Test-Path Alias:wget) {Remove-Item Alias:wget}
'@ | Out-File $PROFILE

. $PROFILE
Write-Host "✅ PowerShell 快捷鍵與個人設定檔已套用" -ForegroundColor Green

Write-Host "🧰 [5/5] 安裝常用應用程式..." -ForegroundColor Cyan
choco install wget 7zip notepad2 everything winmerge powertoys pdfxchangeeditor  -y
if ($?) {
    Write-Host "✅ 工具 (wget, 7zip, notepad2, everything, winmerge, powertoys, pdfxchangeeditor) 安裝完成" -ForegroundColor Green
} else {
    Write-Host "❌ 工具安裝失敗" -ForegroundColor Red
}

choco install googlechrome googlechrome.canary firefox safari brave --ignorechecksums -y
if ($?) {
    Write-Host "✅ 瀏覽器安裝完成" -ForegroundColor Green
} else {
    Write-Host "❌ 瀏覽器安裝失敗" -ForegroundColor Red
}

choco install powershell-core -y
if ($?) {
    Write-Host "✅ PowerShell Core 安裝完成" -ForegroundColor Green
} else {
    Write-Host "❌ PowerShell Core 安裝失敗" -ForegroundColor Red
}

Write-Host "`n🎉 基本環境設定已完成！若沒有後續要執行的，建議重新啟動系統" -ForegroundColor Yellow
Pause
