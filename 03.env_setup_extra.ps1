# 1. 問是否安裝 Visual Studio
$installVS = Read-Host "🧱 [1/2] 是否安裝 Visual Studio 2022 Community？(y/N)"
if ($installVS -match '^[Yy]$') {
    Write-Host "`n⬇ 正在安裝 Visual Studio 2022 Community..." -ForegroundColor Cyan
    choco install visualstudio2022community -y
    if ($?) {
        Write-Host "✅ Visual Studio 2022 Community 安裝完成" -ForegroundColor Green
    } else {
        Write-Host "❌ Visual Studio 安裝失敗" -ForegroundColor Red
    }
} else {
    Write-Host "⏭️ 略過安裝 Visual Studio" -ForegroundColor Yellow
}

# 2. 問是否安裝 SSMS
$installSSMS = Read-Host "`n🧩 [2/2] 是否安裝 SQL Server Management Studio (SSMS)？(y/N)"
if ($installSSMS -match '^[Yy]$') {
    Write-Host "`n⬇ 正在安裝 SQL Server Management Studio (SSMS)..." -ForegroundColor Cyan
    choco install sql-server-management-studio -y
    if ($?) {
        Write-Host "✅ SSMS 安裝完成" -ForegroundColor Green
    } else {
        Write-Host "❌ SSMS 安裝失敗" -ForegroundColor Red
    }
} else {
    Write-Host "⏭️ 略過安裝 SSMS" -ForegroundColor Yellow
}

Write-Host "`n🎉 進階開發工具安裝程序結束，你可以開始進行 .NET 與資料庫開發。" -ForegroundColor Yellow
Pause
