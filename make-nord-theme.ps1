# Simply-Nord: Strict Overlay Build System
# Philosophy: Vanilla Base -> Apply Overrides -> Compile -> Export

param(
    [string]$RepoPath = $PSScriptRoot,
    [string]$VanillaPath = "$PSScriptRoot\searxng-vanilla",
    [string]$OutputPath = "$PSScriptRoot\out"
)

$ErrorActionPreference = "Stop"
$TempBuild = "$env:TEMP\simply-nord-overlay-workdir"

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Simply-Nord" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# 0. Pre-Flight: Clean Workspace
Write-Host "[0] Setting up clean workspace..." -ForegroundColor Gray
if (Test-Path $TempBuild) { Remove-Item $TempBuild -Recurse -Force }
New-Item -ItemType Directory -Path $TempBuild -Force | Out-Null

# 1. THE BASE: Copy Vanilla Repo
Write-Host "[1] Staging Vanilla Base..." -ForegroundColor Gray
if (-not (Test-Path "$VanillaPath\searx\templates\simple")) {
    Write-Error "CRITICAL: Vanilla path seems invalid. Expected to find '\searx\templates\simple' inside $VanillaPath."
    return
}
Copy-Item "$VanillaPath\*" -Destination $TempBuild -Recurse -Force

# 2. OVERLAY 1: Templates (Repo/crabx -> Workspace/searx/templates/simple)
Write-Host "[2] Applying Template Overrides (CrabX)..." -ForegroundColor Cyan
$TemplateTarget = "$TempBuild\searx\templates\simple"
$TemplateSource = "$RepoPath\src\crabx"

if (Test-Path $TemplateSource) {
    # We overwrite the vanilla templates with yours
    Copy-Item "$TemplateSource\*" -Destination $TemplateTarget -Recurse -Force
    Write-Host "    Merged custom templates into build workspace." -ForegroundColor Green
} else {
    Write-Warning "    No custom templates found at $TemplateSource. Using Vanilla templates only."
}

# 3. OVERLAY 2: CSS Injection (FIXED: Inject AFTER Mixins)
Write-Host "[3] Applying CSS Overrides..." -ForegroundColor Cyan
$LessFile = "$TempBuild\client\simple\src\less\style.less"
$OverrideFile = "$RepoPath\src\nord-crab-overrides.less"

if (Test-Path $LessFile) {
    if (Test-Path $OverrideFile) {
        $OverrideContent = Get-Content $OverrideFile -Raw
        $StyleContent = Get-Content $LessFile -Raw
        
        # FIX: We must inject AFTER "mixins.less" so we can use vanilla mixins
        # but BEFORE "toolkit.less" so we can override variables.
        $InjectionPoint = '@import "mixins.less";'
        
        if ($StyleContent -match [regex]::Escape($InjectionPoint)) {
            # Insert overrides immediately after mixins
            $NewContent = $StyleContent -replace [regex]::Escape($InjectionPoint), "$InjectionPoint`n/* NORD START */`n$OverrideContent`n/* NORD END */"
            Set-Content -Path $LessFile -Value $NewContent
            Write-Host "    [Success] Injected LESS overrides after Mixins." -ForegroundColor Green
        }
        else {
            Write-Warning "    [Warning] Could not find injection point. Appending to end."
            Add-Content -Path $LessFile -Value "`n$OverrideContent"
        }
    } else {
        Write-Error "    Override file missing: $OverrideFile"
    }
} else {
    Write-Error "    Target style.less missing in vanilla source: $LessFile"
}

# 4. THE BUILD: Compile the Merged Source
Write-Host "[4] Compiling Theme (Vite/NPM)..." -ForegroundColor Yellow
$BuildDir = "$TempBuild\client\simple"
Push-Location $BuildDir
try {
    # Install dependencies if missing (using the vanilla package.json)
    if (-not (Test-Path "node_modules")) {
        Write-Host "    Installing NPM dependencies..." -ForegroundColor Gray
        npm install --quiet --no-audit --no-fund
    }
    
    # Run the build command defined in vanilla package.json
    Write-Host "    Running production build..." -ForegroundColor Gray
    $env:NODE_ENV = "production"
    npm run build
}
catch {
    Write-Error "    Compilation failed. See NPM output above."
}
finally {
    Pop-Location
    $env:NODE_ENV = $null
}

# 5. EXPORT: Map Workspace to Docker Volume Structure
Write-Host "[5] Exporting to Distribution Folder..." -ForegroundColor Cyan

# Define Output Paths
$OutTemplates = "$OutputPath\crabx"          # Maps to /searx/templates/simple
$OutStatic    = "$OutputPath\crabx-static"   # Maps to /searx/static/themes/simple

# Clean old output
if (Test-Path $OutputPath) { Remove-Item $OutputPath -Recurse -Force }
New-Item -ItemType Directory -Path $OutTemplates -Force | Out-Null
New-Item -ItemType Directory -Path "$OutStatic\css" -Force | Out-Null
New-Item -ItemType Directory -Path "$OutStatic\js" -Force | Out-Null
New-Item -ItemType Directory -Path "$OutStatic\img" -Force | Out-Null

# A. Export Merged Templates
# We copy from the WORKSPACE (which now contains vanilla + your overrides)
Copy-Item "$TemplateTarget\*" -Destination $OutTemplates -Recurse -Force

# B. Export Compiled Assets
# SearXNG build places compiled assets here:
$BuildOutput = "$TempBuild\searx\static\themes\simple"

if (Test-Path $BuildOutput) {
    # CSS
    Get-ChildItem "$BuildOutput\*.css" -Recurse | Copy-Item -Destination "$OutStatic\css" -Force
    # JS
    Get-ChildItem "$BuildOutput\*.js" -Recurse | Copy-Item -Destination "$OutStatic\js" -Force
    # Images
    if (Test-Path "$BuildOutput\img") {
        Copy-Item "$BuildOutput\img\*" -Destination "$OutStatic\img" -Recurse -Force
    }
} else {
    Write-Error "Build output directory not found at $BuildOutput"
}

# 6. Final Verification
Write-Host "`n[6] Verifying Output..." -ForegroundColor Yellow
if (Test-Path "$OutTemplates\results.html") {
    Write-Host "    Templates: OK (results.html found)" -ForegroundColor Green
} else {
    Write-Error "    Templates: FAILED (results.html missing in $OutTemplates)"
}

if (Get-ChildItem "$OutStatic\css\*.css") {
    Write-Host "    CSS:       OK" -ForegroundColor Green
} else {
    Write-Error "    CSS:       FAILED (No CSS files generated)"
}

Write-Host "`nBuild Complete." -ForegroundColor Green