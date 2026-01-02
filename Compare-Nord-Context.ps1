<#
.SYNOPSIS
    Compiles 'less-archive' and 'less-crab-nord' as standalone themes (no vanilla merge)
    and reports the diff.
#>

param(
    [string]$RepoPath = "c:\Users\cra88y\Dev\Repos\simply-nord"
)

$ArchiveDir = Join-Path $RepoPath "less-archive"
$CrabNordDir = Join-Path $RepoPath "less-crab-nord"
$TempRoot = "c:\Users\cra88y\.gemini\temp_diff_simple"

# 0. Clean Temp
if (Test-Path $TempRoot) { Remove-Item $TempRoot -Recurse -Force | Out-Null }
New-Item -ItemType Directory -Path $TempRoot -Force | Out-Null

$NodeModulesSrc = Join-Path $RepoPath "node_modules"

function Compile-Standalone {
    param(
        [string]$SourceName,
        [string]$SourcePath
    )

    Write-Host "[$SourceName] Setting up standalone build..." -ForegroundColor Cyan
    $BuildRoot = Join-Path $TempRoot $SourceName
    # Imitate structure so ../../node_modules works
    # less-files go into $BuildRoot/src/less
    $LessDest = Join-Path $BuildRoot "src\less"
    New-Item -ItemType Directory -Path $LessDest -Force | Out-Null

    # 1. Copy THEME files only (no vanilla)
    Copy-Item "$SourcePath\*" $LessDest -Recurse -Force

    # 2. Link node_modules at $BuildRoot/node_modules
    $NodeModulesDst = Join-Path $BuildRoot "node_modules"
    if (Test-Path $NodeModulesSrc) {
        cmd /c "mklink /J `"$NodeModulesDst`" `"$NodeModulesSrc`"" | Out-Null
    }

    # 2b. Copy 'generated' folder for pygments.less
    $GeneratedSrc = Join-Path $RepoPath "searxng-vanilla\client\simple\generated"
    $GeneratedDst = Join-Path $BuildRoot "generated"
    if (Test-Path $GeneratedSrc) {
        New-Item -ItemType Directory -Path $GeneratedDst -Force | Out-Null
        Copy-Item "$GeneratedSrc\*" $GeneratedDst -Recurse -Force
    }

    # 3. Rename style.less to style-ltr.less if it doesn't exist, 
    # to standardize entry point (repo seems to have both or mixed)
    if (-not (Test-Path "$LessDest\style-ltr.less")) {
        if (Test-Path "$LessDest\style.less") {
             Copy-Item "$LessDest\style.less" "$LessDest\style-ltr.less"
        }
    }

    # 4. Compile
    Write-Host "[$SourceName] Compiling..." -ForegroundColor Gray
    $OutputFile = Join-Path $TempRoot "$SourceName.css"
    
    Push-Location $LessDest
    try {
        cmd /c "npx lessc style-ltr.less $OutputFile"
        if ($LASTEXITCODE -ne 0) { throw "Compilation failed" }
    }
    catch {
        Write-Error "Error compiling $SourceName : $_"
        Pop-Location
        return $null
    }
    Pop-Location

    Write-Host "[$SourceName] Success." -ForegroundColor Green
    return $OutputFile
}

$CssArchive = Compile-Standalone "Archive" $ArchiveDir
$CssCrab = Compile-Standalone "Crab-Nord" $CrabNordDir

# 3. Compare
if ($CssArchive -and $CssCrab) {
    $ReportFile = Join-Path $RepoPath "Diff_Report.diff"
    Write-Host "Generating diff report at $ReportFile..." -ForegroundColor Yellow
    
    if (Get-Command git -ErrorAction SilentlyContinue) {
        # --no-color for LLM readability, --unified=3 for context
        git diff --no-index --no-color --unified=25 $CssArchive $CssCrab > $ReportFile
    } else {
        diff $CssArchive $CssCrab > $ReportFile
    }
}
