# =====================================================
# SYNC ALL — RM. Pondok Marisa POS
# Jalankan script ini setelah edit file di web/
# untuk menyinkronkan ke semua folder
# =====================================================

$root = $PSScriptRoot
$web  = "$root\web"
$android = "$root\android\app\src\main\assets\public"
$menuDigital = "$root\renderer\menu-digital"

Write-Host ""
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  SYNC ALL - RM. PONDOK MARISA POS  " -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# File yang disync dari web/ ke android/
$webFiles = @(
    "admin-app.js",
    "admin-style.css",
    "index.html",
    "kasir.html",
    "laporan.html",
    "menu-app.js",
    "menu-hub.html",
    "menu-style.css",
    "menu.html",
    "pengaturan.html",
    "pesanan-masuk.html",
    "produk.html",
    "qrcode.html",
    "transaksi.html"
)

# 1. Sync web/ → android/
Write-Host "1. Sync web/ → android assets..." -ForegroundColor Yellow
$count = 0
foreach ($f in $webFiles) {
    $src = "$web\$f"
    $dst = "$android\$f"
    if (Test-Path $src) {
        Copy-Item $src $dst -Force
        Write-Host "   OK: $f" -ForegroundColor Green
        $count++
    } else {
        Write-Host "   SKIP (tidak ada): $f" -ForegroundColor Gray
    }
}
Write-Host "   → $count file disync ke android" -ForegroundColor Green
Write-Host ""

# 2. Sync menu-app.js → renderer/menu-digital/app.js
# (hanya bagian logika, bukan Firebase config)
Write-Host "2. Update renderer/menu-digital/app.js..." -ForegroundColor Yellow
Copy-Item "$web\menu-app.js" "$menuDigital\app.js" -Force
Write-Host "   OK: menu-app.js → app.js" -ForegroundColor Green
Write-Host ""

# 3. Sync menu-style.css → renderer/menu-digital/style.css
Write-Host "3. Update renderer/menu-digital/style.css..." -ForegroundColor Yellow
Copy-Item "$web\menu-style.css" "$menuDigital\style.css" -Force
Write-Host "   OK: menu-style.css → style.css" -ForegroundColor Green
Write-Host ""

# 4. Sync menu.html → renderer/menu-digital/index.html
Write-Host "4. Update renderer/menu-digital/index.html..." -ForegroundColor Yellow
Copy-Item "$web\menu.html" "$menuDigital\index.html" -Force
Write-Host "   OK: menu.html → index.html" -ForegroundColor Green
Write-Host ""

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  SYNC SELESAI!" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Langkah selanjutnya:" -ForegroundColor White
Write-Host "  - Build APK: jalankan build_android.bat" -ForegroundColor Gray
Write-Host "  - Push GitHub: git add . && git commit -m 'update' && git push" -ForegroundColor Gray
Write-Host ""
