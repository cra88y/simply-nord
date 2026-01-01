$oldPath = "C:\Users\cra88y\Dev\Repos\searxng-old-custom-less-backup\client\simple\src\less"
$newPath = "c:\Users\cra88y\Dev\Repos\simply-nord\searxng-vanilla\client\simple\src\less"

$files = Get-ChildItem -Path $oldPath -Filter "*.less"

foreach ($file in $files) {
    if (Test-Path "$newPath\$($file.Name)") {
        Write-Host "--- Checking $($file.Name) ---"
        # Compare-Object is slow, let's just find lines containing the target classes in the old file
        Select-String -Path $file.FullName -Pattern ".result-images", ".result-videos", ".result-default", "img.thumbnail", ".result" | ForEach-Object {
            Write-Host "$($_.FileName):$($_.LineNumber): $($_.Line)"
        }
    }
}
