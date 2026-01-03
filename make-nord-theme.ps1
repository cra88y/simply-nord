# Simply-Nord Final Build System (Fixed Asset Routing)
# Generates complete, deployable theme files from Vanilla + Overrides

param(
    [string]$VanillaPath = "$PSScriptRoot\searxng-vanilla",
    [string]$RepoPath = "$PSScriptRoot",
    [string]$OutputPath = "$PSScriptRoot\out"
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
$TempBuild = "$PSScriptRoot\.temp_build"
Write-Host "1. Cleaning temp environment ($TempBuild)..." -ForegroundColor Gray
if (Test-Path $TempBuild) { Remove-Item $TempBuild -Recurse -Force }
New-Item -ItemType Directory -Path $TempBuild -Force | Out-Null

# 2. Start with Vanilla Base (Core SearXNG)
Write-Host "2. Initializing with vanilla base..." -ForegroundColor Gray
if (-not (Test-Path $VanillaPath)) { Write-Error "Vanilla path not found: $VanillaPath"; return }
Copy-Item "$VanillaPath\*" -Destination $TempBuild -Recurse -Force

# 3. Inject Overrides (@import strategy)
Write-Host "3. Injecting Nord & Crab LESS overrides..." -ForegroundColor Cyan
$LessDest = Join-Path $TempBuild "client\simple\src\less"
$OverrideFile = Join-Path $RepoPath "nord-crab-overrides.less"

if (Test-Path $OverrideFile) {
    Copy-Item $OverrideFile $LessDest -Force
    
    # Inject into ENTRY POINTS (ltr and rtl) to ensure it loads LAST and wins specificity
    $EntryFiles = @("style-ltr.less", "style-rtl.less", "style.less") # Added style.less just in case version differs

    foreach ($file in $EntryFiles) {
        $filePath = Join-Path $LessDest $file
        if (Test-Path $filePath) {
            Add-Content $filePath "`n@import `"nord-crab-overrides.less`";"
            Write-Host "   Injected import into $file" -ForegroundColor Gray
        }
    }
} else {
    Write-Warning "   Override file not found at $OverrideFile"
}

# 4. Apply Template Overrides (Repo CrabX -> Vanilla Templates)
Write-Host "4. Merging templates (Repo crabx -> Vanilla templates)..." -ForegroundColor Green
$TemplateDest = Join-Path $TempBuild "searx\templates\simple"
$TemplateSource = Join-Path $RepoPath "crabx"

if (Test-Path $TemplateSource) {
    Get-ChildItem -Path $TemplateSource | ForEach-Object {
        Copy-Item $_.FullName -Destination $TemplateDest -Recurse -Force
    }
} else {
    Write-Warning "   No custom templates found at $TemplateSource. Skipping template merge."
}

# 5. Build CSS via NPM/Vite
Write-Host "5. Compiling LESS to CSS via Vite..." -ForegroundColor Yellow
$ClientDir = Join-Path $TempBuild "client\simple"
Push-Location $ClientDir
try {
    # Ensure dependencies are installed
    if (-not (Test-Path "node_modules")) {
        Write-Host "   Installing node dependencies..." -ForegroundColor Gray
        npm install --quiet --no-audit --no-fund
    }
    
    # Run the build
    Write-Host "   Running build script..." -ForegroundColor Gray
    $env:NODE_ENV = "production"
    npm run build
}
catch {
    Write-Error "Build failed. Check the NPM output above."
}
finally { 
    Pop-Location 
    $env:NODE_ENV = $null
}

# 6. Export to /out/ matching Docker Volume Structure
Write-Host "6. Exporting final build to $OutputPath..." -ForegroundColor Cyan

# Cleanup old out
if (Test-Path $OutputPath) { Remove-Item $OutputPath -Recurse -Force }

# Define Output Structure
$OutTemplates = Join-Path $OutputPath "crabx"          # Maps to /searx/templates/simple
$OutStatic    = Join-Path $OutputPath "crabx-static"   
$OutCss       = Join-Path $OutStatic "css"             # Maps to /searx/static/themes/simple/css
$OutJs        = Join-Path $OutStatic "js"              # Maps to /searx/static/themes/simple/js
$OutImg       = Join-Path $OutStatic "img"

New-Item -ItemType Directory -Path $OutTemplates -Force | Out-Null
New-Item -ItemType Directory -Path $OutCss -Force | Out-Null
New-Item -ItemType Directory -Path $OutJs -Force | Out-Null
New-Item -ItemType Directory -Path $OutImg -Force | Out-Null

# --- A. Export Templates ---
Write-Host "   Exporting Templates..." -ForegroundColor Gray
Copy-Item "$TemplateDest\*" $OutTemplates -Recurse -Force

# --- B. Export Static Assets ---
# Locate where the build dumped the files. 
# Newer SearXNG puts them in searx/static/themes/simple/css OR just searx/static/themes/simple/
$BuiltStaticBase = Join-Path $TempBuild "searx\static\themes\simple"

Write-Host "   Exporting CSS..." -ForegroundColor Gray
# Strategy: Find ALL .css files in the build output (recursive) and flatten them into the output CSS folder
# This handles both flat structures and css/ subfolder structures
Get-ChildItem -Path $BuiltStaticBase -Filter "*.css" -Recurse | ForEach-Object {
    Copy-Item $_.FullName -Destination $OutCss -Force
}

Write-Host "   Exporting JS..." -ForegroundColor Gray
Get-ChildItem -Path $BuiltStaticBase -Filter "*.js" -Recurse | ForEach-Object {
    Copy-Item $_.FullName -Destination $OutJs -Force
}

Write-Host "   Exporting Images..." -ForegroundColor Gray
$ImgSource = Join-Path $BuiltStaticBase "img"
if (Test-Path $ImgSource) {
    Copy-Item "$ImgSource\*" $OutImg -Recurse -Force
}

Write-Host "`nBuild Successful!" -ForegroundColor Green
Write-Host "--------------------------------------------------" -ForegroundColor Gray
Write-Host "Docker Volume Mapping Guide:" -ForegroundColor White
Write-Host "1. Templates:" -ForegroundColor Yellow
Write-Host "   Host: $OutTemplates"
Write-Host "   Cont: /usr/local/searxng/searx/templates/simple"
Write-Host "2. CSS:" -ForegroundColor Yellow
Write-Host "   Host: $OutCss"
Write-Host "   Cont: /usr/local/searxng/searx/static/themes/simple/css"
Write-Host "3. JS (Recommended to Add):" -ForegroundColor Red
Write-Host "   Host: $OutJs"
Write-Host "   Cont: /usr/local/searxng/searx/static/themes/simple/js"
Write-Host "--------------------------------------------------" -ForegroundColor Gray