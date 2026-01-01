# Simply-Nord Final Build System (Fixed Asset Routing)
# Generates complete, deployable theme files from Vanilla + Overrides

param(
    [string]$VanillaPath = "$PSScriptRoot\searxng-vanilla",
    [string]$RepoPath = "c:\Users\cra88y\Dev\Repos\simply-nord",
    [string]$OutputPath = "c:\Users\cra88y\Dev\Repos\simply-nord\out"
)

$ErrorActionPreference = "Stop"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Simply-Nord: Full Distribution Build" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# 0. Pre-Flight Check
if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Error "NPM is not installed or not in PATH. Please install Node.js to compile the theme."
    return
}

# 1. Setup Build Environment
$TempBuild = "c:\Users\cra88y\.gemini\temp_build_final"
if (Test-Path $TempBuild) { Remove-Item $TempBuild -Recurse -Force }
New-Item -ItemType Directory -Path $TempBuild -Force | Out-Null

# 2. Start with Vanilla Base (Core SearXNG)
Write-Host "1. Initializing with vanilla base..." -ForegroundColor Gray
Get-ChildItem -Path $VanillaPath | ForEach-Object {
    Copy-Item $_.FullName -Destination $TempBuild -Recurse -Force
}

# 3. Inject Overrides (@import strategy)
Write-Host "2. Injecting Nord & Crab LESS overrides..." -ForegroundColor Cyan
$LessDest = Join-Path $TempBuild "client\simple\src\less"
Copy-Item (Join-Path $RepoPath "nord-crab-overrides.less") $LessDest -Force

# FIX: Inject into ENTRY POINTS (ltr and rtl) to ensure it loads LAST and wins specificity
$EntryFiles = @("style-ltr.less", "style-rtl.less")

foreach ($file in $EntryFiles) {
    $filePath = Join-Path $LessDest $file
    if (Test-Path $filePath) {
        Add-Content $filePath "`n@import `"nord-crab-overrides.less`";"
        Write-Host "   Injected import into $file" -ForegroundColor Gray
    } else {
        Write-Warning "   Could not find entry file: $file"
    }
}

# 4. Apply Template Overrides (Repo CrabX -> Vanilla Templates)
Write-Host "3. Merging templates (Repo crabx -> Vanilla templates)..." -ForegroundColor Green
$TemplateDest = Join-Path $TempBuild "searx\templates\simple"
$TemplateSource = Join-Path $RepoPath "crabx"
if (Test-Path $TemplateSource) {
    Get-ChildItem -Path $TemplateSource | ForEach-Object {
        Copy-Item $_.FullName -Destination $TemplateDest -Recurse -Force
    }
} else {
    Write-Warning "   No custom templates found at $TemplateSource. Skipping template merge."
}

# 5. Build CSS
Write-Host "4. Compiling LESS to CSS via Vite..." -ForegroundColor Yellow
$ClientDir = Join-Path $TempBuild "client\simple"
Push-Location $ClientDir
try {
    if (-not (Test-Path "node_modules")) {
        Write-Host "   Installing node dependencies..." -ForegroundColor Gray
        npm install --quiet
    }
    npm run build
}
catch {
    Write-Error "Build failed. Check the NPM output above."
}
finally { Pop-Location }

# 6. Export to /out/ with Legacy Path Mapping
Write-Host "5. Exporting final build to $OutputPath..." -ForegroundColor Cyan

# Cleanup old out
if (Test-Path $OutputPath) { Remove-Item $OutputPath -Recurse -Force }
$OutCrabx = Join-Path $OutputPath "crabx"
$OutCrabxStatic = Join-Path $OutputPath "crabx-static"
$OutCss = Join-Path $OutCrabxStatic "css"
$OutJs = Join-Path $OutCrabxStatic "js"
$OutImg = Join-Path $OutCrabxStatic "img"

New-Item -ItemType Directory -Path $OutCrabx -Force | Out-Null
New-Item -ItemType Directory -Path $OutCss -Force | Out-Null
New-Item -ItemType Directory -Path $OutJs -Force | Out-Null
New-Item -ItemType Directory -Path $OutImg -Force | Out-Null

# Copy finished templates
Copy-Item "$TemplateDest\*" $OutCrabx -Recurse -Force

# Map New Assets to Legacy Names Used in base.html
$BuiltStatic = Join-Path $TempBuild "searx\static\themes\simple"

Write-Host "   Mapping assets to legacy paths..." -ForegroundColor Gray

# CSS Mapping
if (Test-Path (Join-Path $BuiltStatic "sxng-ltr.min.css")) {
    Copy-Item (Join-Path $BuiltStatic "sxng-ltr.min.css") (Join-Path $OutCss "searxng.min.css") -Force
}
if (Test-Path (Join-Path $BuiltStatic "sxng-rtl.min.css")) {
    Copy-Item (Join-Path $BuiltStatic "sxng-rtl.min.css") (Join-Path $OutCss "searxng-rtl.min.css") -Force
}
# Keep pygments/other CSS if they exist
Get-ChildItem -Path $BuiltStatic -Filter "*.css" | ForEach-Object {
    if ($_.Name -notmatch "sxng-") {
        Copy-Item $_.FullName $OutCss -Force
    }
}

# JS Mapping
if (Test-Path (Join-Path $BuiltStatic "sxng-core.min.js")) {
    Copy-Item (Join-Path $BuiltStatic "sxng-core.min.js") (Join-Path $OutJs "searxng.min.js") -Force
}

# Copy chunks and other JS (Modern builds rely on these)
if (Test-Path (Join-Path $BuiltStatic "chunk")) {
    Copy-Item (Join-Path $BuiltStatic "chunk") $OutJs -Recurse -Force
}

# Image Mapping
if (Test-Path (Join-Path $BuiltStatic "img")) {
    Copy-Item "$(Join-Path $BuiltStatic 'img')\*" $OutImg -Recurse -Force
}

Write-Host "`nBuild Successful!" -ForegroundColor Green
Write-Host "Deployment Summary:" -ForegroundColor White
Write-Host " - Templates: $OutCrabx"
Write-Host " - CSS:       $OutCss/searxng.min.css"
Write-Host " - JS:        $OutJs/searxng.min.js"