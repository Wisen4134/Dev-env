# ================================
# 環境安裝主控腳本
# ================================

Try {
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
} Catch {
    Write-Host "⚠️ 無法設定執行權限，請使用 [以系統管理員身份] 執行 PowerShell。" -ForegroundColor Red
    Pause
    Exit
}

Clear-Host
Write-Host "===================================" -ForegroundColor Cyan
Write-Host "🛠️  環境安裝工具" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

# 📦 Step 1. 安裝基本環境（必裝）NuGet、 改系統語言為TW、 安裝 Chocolatey(Windows套件管理器)、 設定 PowerShell 快捷鍵與個人化檔案、 常用工具(wget 7zip notepad2 everything WinMerge PowerToys)、 瀏覽器
Write-Host "🔹 [Step 1/3] 安裝基本環境..." -ForegroundColor Yellow
& "$PSScriptRoot\01.env_setup_base.ps1"

# ❓ Step 2. 詢問是否為開發人員
$devInput = Read-Host "`n❓ 請問您是開發人員嗎？(Y/N)"
if ($devInput -match '^[Yy]') {
    Write-Host "`n🔹 [Step 2/3] 安裝開發人員工具..." -ForegroundColor Yellow
    & "$PSScriptRoot\02.env_setup_dev.ps1"

    # ❓ Step 3. 再詢問是否需要進階工具
    $vsInput = Read-Host "`n❓ 是否可能需要安裝 Visual Studio 2022 與 SQL Server Management Studio？(Y/N)"
    if ($vsInput -match '^[Yy]') {
        Write-Host "`n🔹 [Step 3/3] 安裝進階開發工具..." -ForegroundColor Yellow
        & "$PSScriptRoot\03.env_setup_extra.ps1"
    } else {
        Write-Host "➡️ 跳過進階開發工具安裝。" -ForegroundColor DarkGray
    }
} else {
    Write-Host "`n✅ 非開發人員安裝完畢。" -ForegroundColor Green
}

Write-Host "`n🎉 所有環境安裝作業已完成！請重新開機以確保 PATH 設定套用成功。" -ForegroundColor Green
Pause