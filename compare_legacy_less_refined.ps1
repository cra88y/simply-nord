$diffPath = "c:\Users\cra88y\Dev\Repos\simply-nord\diff_legacy_archive_refined.txt"
$lessPath = "C:\Users\cra88y\Dev\Repos\searxng-old-custom-less-backup\client\simple\src\less"
$archivePath = "C:\Users\cra88y\Dev\Repos\searxng-old-custom-less-backup\client\simple\src\less-archive\less"

"Diff Report: LESS vs LESS-ARCHIVE/LESS" > $diffPath

$files = Get-ChildItem -Path $lessPath -Filter "*.less"
foreach ($file in $files) {
    # Check if a corresponding file exists in less-archive/less
    $archiveFile = Join-Path $archivePath $file.Name
    
    if (Test-Path $archiveFile) {
        $lessContent = Get-Content $file.FullName
        $archiveContent = Get-Content $archiveFile

        $diff = Compare-Object -ReferenceObject $archiveContent -DifferenceObject $lessContent
        if ($diff) {
            "--- Diff for $($file.Name) ---" >> $diffPath
            $diff | ForEach-Object {
                if ($_.SideIndicator -eq "<=") {
                    "- $($_.InputObject)" >> $diffPath
                } else {
                    "+ $($_.InputObject)" >> $diffPath
                }
            }
        } else {
             # "--- No Changes: $($file.Name) ---" >> $diffPath
        }
    } else {
         "--- New File (Only in Current): $($file.Name) ---" >> $diffPath
    }
}
