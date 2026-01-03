# Simply-Nord: Strict Overlay Build System (Refactored)
# Philosophy: Verify Env -> Stage -> Inject -> Build -> Export
# Version: 3.1 - "Reliable NPM Install" Edition

param(
    [string]$RepoPath = $PSScriptRoot,
    [string]$VanillaPath = "$PSScriptRoot\searxng-vanilla",
    [string]$OutputPath = "$PSScriptRoot\out"
)

# --- Script Configuration & Helpers (condensed) ---
$ErrorActionPreference = "Stop"
$TempBuildPath = "$env:TEMP\simply-nord-build-workdir"
$global:PythonExecutable = $null
function Write-Log { param([string]$Step, [string]$Message, [string]$Color = "Gray"); Write-Host "[$Step] $Message" -ForegroundColor $Color }
function Check-Dependencies {
    Write-Log "PRE" "Verifying build environment..."
    if (Get-Command python.exe -ErrorAction SilentlyContinue) { $global:PythonExecutable = "python.exe" }
    elseif (Get-Command py.exe -ErrorAction SilentlyContinue) { $global:PythonExecutable = "py.exe" }
    if (-not $global:PythonExecutable) { Write-Error "CRITICAL: Python not found."; exit 1 }
    if (-not (Get-Command npm.cmd -ErrorAction SilentlyContinue)) { Write-Error "CRITICAL: Node.js/NPM not found."; exit 1 }
    Write-Log "PRE" "  -> Build environment is OK." -Color Green
}

# ==============================================================================
# SCRIPT EXECUTION
# ==============================================================================

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Simply-Nord Theme Builder v3.1" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# --- STEP 0 & 1: PRE-FLIGHT & STAGING (condensed) ---
Check-Dependencies
Write-Log "0" "Setting up clean build workspace..."
if (Test-Path $TempBuildPath) { Remove-Item $TempBuildPath -Recurse -Force }
New-Item -ItemType Directory -Path $TempBuildPath -Force | Out-Null
Write-Log "1" "Staging vanilla SearXNG source into workspace..."
Copy-Item -Path (Join-Path $VanillaPath "*") -Destination $TempBuildPath -Recurse -Force

# --- STEP 2: INJECT OVERRIDES (condensed) ---
Write-Log "2" "Injecting custom theme overrides..." -Color Cyan
$TemplateTarget = Join-Path $TempBuildPath "searx\templates\simple"
$TemplateSource = Join-Path $RepoPath "src\crabx"
if (Test-Path $TemplateSource) { Copy-Item -Path (Join-Path $TemplateSource "*") -Destination $TemplateTarget -Recurse -Force }
$OverrideSourceFile = Join-Path $RepoPath "src\nord-crab-overrides.less"
$LessTargetDir = Join-Path $TempBuildPath "client\simple\src\less"
$MainLessFile = Join-Path $LessTargetDir "style.less"
if (-not (Test-Path $OverrideSourceFile)) { Write-Error "CRITICAL: Override file not found."; return }
Copy-Item -Path $OverrideSourceFile -Destination $LessTargetDir -Force
$ImportStatement = "`n// --- Simply-Nord Theme Injection ---`n@import `"nord-crab-overrides.less`";"
Add-Content -Path $MainLessFile -Value $ImportStatement

# --- STEP 3: SETUP DEPENDENCIES & BUILD ---
Write-Log "3" "Setting up dependencies & Compiling..." -Color Yellow
$PythonVenvPath = Join-Path $TempBuildPath ".venv"
$BuildDir = Join-Path $TempBuildPath "client\simple"
try {
    # Setup Python Env & Install Deps
    & $global:PythonExecutable -m venv $PythonVenvPath
    $PipExe = Join-Path $PythonVenvPath "Scripts\pip.exe"
    & $PipExe install -r (Join-Path $TempBuildPath "requirements.txt")
    
    # *** ROOT CAUSE FIX: Always run npm install to ensure all dependencies are present ***
    Push-Location $BuildDir
    Write-Log "3" "  -> Ensuring NPM dependencies are installed..."
    npm install --quiet --no-audit --no-fund
    
    # Run Pygments Pre-build
    $VenvPythonExe = Join-Path $PythonVenvPath "Scripts\python.exe"
    $PygmentsScript = Join-Path $TempBuildPath "searxng_extra\update\update_pygments.py"
    $env:PYTHONPATH = $TempBuildPath
    & $VenvPythonExe $PygmentsScript
    if ($LASTEXITCODE -ne 0) { throw "Pygments script failed." }
    
    # Run Vite Production Build
    Write-Log "3" "  -> Running full theme build..."
    $env:NODE_ENV = "production"
    npm run build
    if ($LASTEXITCODE -ne 0) { throw "NPM build failed." }
    
    Write-Log "3" "  -> Build process completed successfully." -Color Green
}
catch {
    Write-Error "COMPILATION FAILED: $_"
    return
}
finally {
    $env:PYTHONPATH = $null
    $env:NODE_ENV = $null
    Pop-Location
}

# --- STEP 4 & 5: EXPORT, CLEANUP, VERIFY (condensed) ---
Write-Log "4" "Exporting final assets..."
# ... (rest of the script is unchanged)
$OutTemplates = Join-Path $OutputPath "crabx"
$OutStatic = Join-Path $OutputPath "crabx-static"
if (Test-Path $OutputPath) { Remove-Item $OutputPath -Recurse -Force }
New-Item -ItemType Directory -Path $OutTemplates -Force | Out-Null
New-Item -ItemType Directory -Path $OutStatic -Force | Out-Null
Copy-Item -Path (Join-Path $TemplateTarget "*") -Destination $OutTemplates -Recurse -Force
$BuildOutput = Join-Path $TempBuildPath "searx\static\themes\simple"
if (Test-Path $BuildOutput) { Copy-Item -Path (Join-Path $BuildOutput "*") -Destination $OutStatic -Recurse -Force } else { Write-Error "CRITICAL: Build output directory not found."; return }
Write-Log "5" "Cleaning up and Verifying..."
Remove-Item $TempBuildPath -Recurse -Force
if (Test-Path (Join-Path $OutTemplates "results.html")) { Write-Log "5" "  -> Templates: OK" -Color Green } else { Write-Error "VERIFICATION FAILED: 'results.html' missing." }
if ((Get-ChildItem -Path $OutStatic -Filter "sxng-ltr.min.css").Count -gt 0) { Write-Log "5" "  -> Static Assets: OK" -Color Green } else { Write-Error "VERIFICATION FAILED: 'sxng-ltr.min.css' missing." }

Write-Host "`nBuild complete. Output is ready in '$OutputPath'." -ForegroundColor Green