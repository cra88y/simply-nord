# Simply-Nord: Strict Overlay Build System (Refactored)
# Philosophy: Verify Env -> Stage -> Setup -> Overlay -> Build -> Export
# Version: 2.4 - "PYTHONPATH Fix" Edition

param(
    # The root of your Simply-Nord project.
    [string]$RepoPath = $PSScriptRoot,
    # A clean, local clone of the official SearXNG repository.
    [string]$VanillaPath = "$PSScriptRoot\searxng-vanilla",
    # The final output directory for Docker volumes.
    [string]$OutputPath = "$PSScriptRoot\out"
)

# --- Script Configuration ---
$ErrorActionPreference = "Stop"
$TempBuildPath = "$env:TEMP\simply-nord-build-workdir"
$global:PythonExecutable = $null

# --- Helper Functions ---
function Write-Log {
    param([string]$Step, [string]$Message, [string]$Color = "Gray")
    Write-Host "[$Step] $Message" -ForegroundColor $Color
}

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
Write-Host "Simply-Nord Theme Builder v2.4" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# --- STEP 0-3 (No changes, condensed for brevity) ---
Check-Dependencies
Write-Log "0" "Setting up clean build workspace..."
if (Test-Path $TempBuildPath) { Remove-Item $TempBuildPath -Recurse -Force }
New-Item -ItemType Directory -Path $TempBuildPath -Force | Out-Null
Write-Log "1" "Staging vanilla SearXNG source into workspace..."
Copy-Item -Path (Join-Path $VanillaPath "*") -Destination $TempBuildPath -Recurse -Force
Write-Log "2" "Setting up build dependencies..." -Color Yellow
$PythonVenvPath = Join-Path $TempBuildPath ".venv"
try {
    & $global:PythonExecutable -m venv $PythonVenvPath
    $PipExe = Join-Path $PythonVenvPath "Scripts\pip.exe"
    & $PipExe install -r (Join-Path $TempBuildPath "requirements.txt")
    $BuildDir = Join-Path $TempBuildPath "client\simple"
    Push-Location $BuildDir
    if (-not (Test-Path "node_modules")) { npm install --quiet --no-audit --no-fund }
    Pop-Location
} catch { Write-Error "DEPENDENCY SETUP FAILED."; return }
Write-Log "3" "Applying source file overrides..."
$TemplateTarget = Join-Path $TempBuildPath "searx\templates\simple"
$TemplateSource = Join-Path $RepoPath "src\crabx"
if (Test-Path $TemplateSource) { Copy-Item -Path (Join-Path $TemplateSource "*") -Destination $TemplateTarget -Recurse -Force }
$LessTarget = Join-Path $TempBuildPath "client\simple\src\less\style.less"
$LessSource = Join-Path $RepoPath "src\nord-crab-overrides.less"
if (Test-Path $LessSource) { Copy-Item -Path $LessSource -Destination $LessTarget -Force } else { Write-Error "CRITICAL: LESS override file not found."; return }

# --- STEP 4: RUN THE OFFICIAL BUILD PROCESS ---
Write-Log "4" "Compiling theme..." -Color Yellow
$BuildDir = Join-Path $TempBuildPath "client\simple"
Push-Location $BuildDir
try {
    Write-Log "4" "  -> Generating Pygments styles..."
    $VenvPythonExe = Join-Path $PythonVenvPath "Scripts\python.exe"
    $PygmentsScript = Join-Path $TempBuildPath "searxng_extra\update\update_pygments.py"
    
    # *** ROOT CAUSE FIX: Set the PYTHONPATH environment variable ***
    # This tells Python where to find the 'searx' source module.
    $env:PYTHONPATH = $TempBuildPath
    
    & $VenvPythonExe $PygmentsScript
    if ($LASTEXITCODE -ne 0) {
        throw "Pygments script failed with exit code $LASTEXITCODE. Build cannot continue."
    }
    
    Write-Log "4" "  -> Running Vite production build (npm run build)..."
    $env:NODE_ENV = "production"
    npm run build
    if ($LASTEXITCODE -ne 0) {
        throw "NPM build failed with exit code $LASTEXITCODE."
    }
    
    Write-Log "4" "  -> Build process completed successfully." -Color Green
}
catch {
    Write-Error "COMPILATION FAILED: $_"
    return
}
finally {
    # Clean up the environment variable
    $env:PYTHONPATH = $null
    Pop-Location
}

# --- STEP 5 & 6 (No changes, condensed for brevity) ---
Write-Log "5" "Exporting final assets..." -Color Cyan
$OutTemplates = Join-Path $OutputPath "crabx"
$OutStatic = Join-Path $OutputPath "crabx-static"
if (Test-Path $OutputPath) { Remove-Item $OutputPath -Recurse -Force }
New-Item -ItemType Directory -Path $OutTemplates -Force | Out-Null
New-Item -ItemType Directory -Path $OutStatic -Force | Out-Null
Copy-Item -Path (Join-Path $TemplateTarget "*") -Destination $OutTemplates -Recurse -Force
$BuildOutput = Join-Path $TempBuildPath "searx\static\themes\simple"
if (Test-Path $BuildOutput) { Copy-Item -Path (Join-Path $BuildOutput "*") -Destination $OutStatic -Recurse -Force } else { Write-Error "CRITICAL: Build output directory not found."; return }
Write-Log "6" "Cleaning up and Verifying..."
Remove-Item $TempBuildPath -Recurse -Force
if (Test-Path (Join-Path $OutTemplates "results.html")) { Write-Log "6" "  -> Templates: OK" -Color Green } else { Write-Error "VERIFICATION FAILED: 'results.html' missing." }
if ((Get-ChildItem -Path $OutStatic -Filter "sxng-ltr.min.css").Count -gt 0) { Write-Log "6" "  -> Static Assets: OK" -Color Green } else { Write-Error "VERIFICATION FAILED: 'sxng-ltr.min.css' missing." }

Write-Host "`nBuild complete. Output is ready in '$OutputPath'." -ForegroundColor Green