# Simply-Nord Build Verification Tool
# Checks if the "Direct Paste" injection worked and if CSS is compiling correctly.

param(
    [string]$RepoPath = $PSScriptRoot,
    # FIX: Use string interpolation instead of Join-Path
    [string]$TempBuild = "$env:TEMP\simply-nord-build-workspace",
    [string]$OutputPath = "$PSScriptRoot\out"
)

Clear-Host
Write-Host "=== SIMPLY-NORD BUILD VERIFICATION ===" -ForegroundColor Cyan
Write-Host "Checking build at: $TempBuild" -ForegroundColor Gray

# 1. Check Injection in Source (The "Direct Paste")
Write-Host "`n[1] Checking Source Injection (style.less)..." -ForegroundColor Yellow
$StyleLess = Join-Path $TempBuild "client\simple\src\less\style.less"

if (Test-Path $StyleLess) {
    $content = Get-Content $StyleLess -Raw
    
    # Check for the specific markers we added in the build script
    if ($content -match "FORCED NORD OVERRIDES START") {
        Write-Host "  SUCCESS: Found injection markers in style.less" -ForegroundColor Green
        
        # Check if the actual content is there (look for a Nord variable)
        if ($content -match "@nord0:") {
            Write-Host "  SUCCESS: Found Nord variables inside style.less" -ForegroundColor Green
        } else {
            Write-Host "  WARNING: Markers found, but specific Nord variables missing?" -ForegroundColor Yellow
        }
    } else {
        Write-Host "  FAILURE: Injection markers NOT found. Did the build script run?" -ForegroundColor Red
    }
} else {
    Write-Host "  CRITICAL: style.less not found in temp build." -ForegroundColor Red
}

# 2. Check Compiled Output (The Final CSS)
Write-Host "`n[2] Checking Compiled CSS..." -ForegroundColor Yellow
$CssDir = Join-Path $OutputPath "crabx-static\css"

if (Test-Path $CssDir) {
    $CssFiles = Get-ChildItem $CssDir -Filter "*.css"
    
    if ($CssFiles) {
        foreach ($file in $CssFiles) {
            $cssContent = Get-Content $file.FullName -Raw
            
            # Check for Nord Dark Blue Hex (#2e3440)
            # Since variables are compiled away, we look for the resulting Hex code
            if ($cssContent -match "2e3440") {
                Write-Host "  MATCH ($($file.Name)): Contains Nord Dark Blue (#2e3440)" -ForegroundColor Green
            } 
            # Check for the pill shape radius (50px)
            elseif ($cssContent -match "50px") {
                 Write-Host "  MATCH ($($file.Name)): Contains 50px border-radius (Pill Shape)" -ForegroundColor Green
            }
            else {
                Write-Host "  NO MATCH ($($file.Name)): Likely a secondary file (RSS/Map)." -ForegroundColor Gray
            }
        }
    } else {
        Write-Host "  FAILURE: No .css files found in output folder." -ForegroundColor Red
    }
} else {
    Write-Host "  FAILURE: Output CSS directory does not exist." -ForegroundColor Red
}

# 3. Check JS Output (Crucial for functionality)
Write-Host "`n[3] Checking JS Output..." -ForegroundColor Yellow
$JsDir = Join-Path $OutputPath "crabx-static\js"
if ((Test-Path $JsDir) -and (Get-ChildItem $JsDir -Filter "*.js")) {
    Write-Host "  SUCCESS: JS files exist." -ForegroundColor Green
} else {
    Write-Host "  WARNING: JS files missing. Search might be broken." -ForegroundColor Red
}


Write-Host "`n=== VERIFICATION COMPLETE ===" -ForegroundColor Cyan