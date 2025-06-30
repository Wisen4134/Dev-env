# 🛠️ 電腦環境初始化工具

自動化 PowerShell 腳本，快速完成基礎環境安裝與開發工具部署。

---

## 📌 功能總覽

- ⚙️ 自動安裝常用工具（Git、7zip、瀏覽器、PowerShell Core...）
- 👨‍💻 開發者可選擇安裝 VSCode、Node.js、.NET SDK、NPM 套件等
- 🧱 可選擇是否安裝 Visual Studio 2022 + SSMS
- 🧠 自動設定 Git 使用者資訊與常用 alias
- 🌐 自動設定系統語言為繁體中文（zh-TW）

---

## 📁 檔案說明

| 檔案名稱                | 說明 |
|-------------------------|------|
| `env_setup.ps1`         | 主控腳本（使用者只需執行這支） |
| `00.env_setup_env.ps1`  | 通用前置設定（TLS、快捷鍵、初始設定） |
| `01.env_setup_base.ps1` | 所有人都需安裝的基本工具 |
| `02.env_setup_dev.ps1`  | 開發人員用的工具與 Git 設定 |
| `03.env_setup_extra.ps1`| 開發者進階工具（Visual Studio 2022 + SSMS） |

---
## 🚀 如何使用

> 請使用「**以系統管理員身份執行 PowerShell**」開啟本資料夾後執行：

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\env_setup.ps1
```

---

## 🧩 執行流程示意

```
啟動 env_setup.ps1
├── ✅ 執行 01.env_setup_base.ps1（基本安裝）
├── ❓ 是否為開發人員？
│   ├── 是 → 執行 02.env_setup_dev.ps1
│   │         └── ❓ 是否需要 Visual Studio / SSMS？
│   │               └── 是 → 執行 03.env_setup_extra.ps1
│   └── 否 → 完成
└── 🎉 所有步驟完成，請重新開機
```

## 🧱 Entity Framework CLI 工具支援

在 `02.env_setup_dev.ps1` 中，已自動檢查與安裝 **EF Core Scaffold CLI 工具：`dotnet-ef`**。

### 📦 dotnet-ef 功能簡介：

- 從資料庫反向產生 Entity 與 DbContext
- 自動產出模型檔案至 `Entities/` 與 `DbContexts/`
- 用於微服務模組 Scaffold 一致化管理

### 🔎 執行範例：

```powershell
dotnet ef dbcontext scaffold "Server=...;Database=..." Microsoft.EntityFrameworkCore.SqlServer
```

若想手動更新 CLI 工具版本，也可使用：

```powershell
dotnet tool update --global dotnet-ef
```

執行完畢後，腳本會顯示當前版本資訊。

---

## 🧑‍💻 注意事項

- 請確認你有 **系統管理員權限**
- 建議重開機以套用 PATH 與語言設定
- 執行期間請保持網路穩定

