$crabxPath = "c:\Users\cra88y\Dev\Repos\simply-nord\crabx"
$vanillaPath = "c:\Users\cra88y\Dev\Repos\simply-nord\searxng-vanilla\searx\templates\simple"

$files = Get-ChildItem -Path $crabxPath -Recurse -File

foreach ($file in $files) {
    # Get relative path from crabx root
    $relativePath = $file.FullName.Substring($crabxPath.Length + 1)
    
    # Construct corresponding vanilla path
    $originalPath = Join-Path $vanillaPath $relativePath
    
    if (Test-Path $originalPath) {
        # Compare contents (ignoring line endings inconsistencies if any, by reading as string)
        $crabxContent = Get-Content $file.FullName -Raw
        $vanillaContent = Get-Content $originalPath -Raw

        # Normalize line endings just in case
        $crabxContent = $crabxContent -replace "\r\n", "`n"
        $vanillaContent = $vanillaContent -replace "\r\n", "`n"

        if ($crabxContent -eq $vanillaContent) {
            Write-Host "Deleting identical file: $relativePath"
            Remove-Item $file.FullName -Force
        } else {
            # Optional: Write-Host "Keeping modified file: $relativePath"
        }
    } else {
        Write-Host "New file (not in vanilla): $relativePath"
    }
}

# Clean up empty directories in crabx
Get-ChildItem -Path $crabxPath -Recurse -Directory | Sort-Object FullName -Descending | ForEach-Object {
    if ((Get-ChildItem -Path $_.FullName).Count -eq 0) {
        Write-Host "Removing empty directory: $($_.FullName)"
        Remove-Item $_.FullName -Force
    }
}
