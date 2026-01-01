$crabxPath = "c:\Users\cra88y\Dev\Repos\simply-nord\crabx"
$vanillaPath = "c:\Users\cra88y\Dev\Repos\simply-nord\searxng-vanilla\searx\templates\simple"

$files = Get-ChildItem -Path $crabxPath -Recurse -File

foreach ($file in $files) {
    $relativePath = $file.FullName.Substring($crabxPath.Length + 1)
    $originalPath = Join-Path $vanillaPath $relativePath
    
    if (Test-Path $originalPath) {
        $diff = Compare-Object (Get-Content $originalPath) (Get-Content $file.FullName)
        if ($diff) {
            Write-Host "`n=== $relativePath ===" -ForegroundColor Cyan
            # Summarize the diff
            $added = ($diff | Where-Object SideIndicator -eq "=>").Count
            $removed = ($diff | Where-Object SideIndicator -eq "<=").Count
            Write-Host "Lines Added: $added | Lines Removed: $removed" -ForegroundColor Gray
            
            # Show the first few changes to give context
            $diff | Select-Object -First 10 | ForEach-Object {
                if ($_.SideIndicator -eq "<=") {
                    Write-Host "- $($_.InputObject.Trim())" -ForegroundColor Red
                } else {
                    Write-Host "+ $($_.InputObject.Trim())" -ForegroundColor Green
                }
            }
            if ($diff.Count -gt 10) { Write-Host "... ($($diff.Count - 10) more lines)" -ForegroundColor Gray }
        }
    }
}
