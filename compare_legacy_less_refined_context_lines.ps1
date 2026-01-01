$diffPath = "c:\Users\cra88y\Dev\Repos\simply-nord\diff_legacy_archive_refined_context_lines.txt"
$lessPath = "C:\Users\cra88y\Dev\Repos\searxng-old-custom-less-backup\client\simple\src\less"
$archivePath = "C:\Users\cra88y\Dev\Repos\searxng-old-custom-less-backup\client\simple\src\less-archive\less"

"Diff Report: LESS vs LESS-ARCHIVE/LESS (With Context & Line Numbers)" > $diffPath

$files = Get-ChildItem -Path $lessPath -Filter "*.less"
foreach ($file in $files) {
    $archiveFile = Join-Path $archivePath $file.Name
    
    if (Test-Path $archiveFile) {
        $lessContent = Get-Content $file.FullName
        $archiveContent = Get-Content $archiveFile
        
        "web`n`n=== Diff for $($file.Name) ===" >> $diffPath
        
        $maxLines = [Math]::Max($lessContent.Count, $archiveContent.Count)
        
        for ($i = 0; $i -lt $maxLines; $i++) {
            $lLine = if ($i -lt $lessContent.Count) { $lessContent[$i] } else { $null }
            $aLine = if ($i -lt $archiveContent.Count) { $archiveContent[$i] } else { $null }
            
            if ($lLine -ne $aLine) {
                 $start = [Math]::Max(0, $i - 3)
                 $end = [Math]::Min($maxLines - 1, $i + 3)
                 
                 "..." >> $diffPath
                 for ($j = $start; $j -le $end; $j++) {
                      $lineNum = $j + 1
                      $curL = if ($j -lt $lessContent.Count) { $lessContent[$j] } else { "" }
                      $curA = if ($j -lt $archiveContent.Count) { $archiveContent[$j] } else { "" }
                      
                      if ($curL -ne $curA) {
                          if ($curA -ne $null) { "- ${lineNum}: ${curA}" >> $diffPath }
                          if ($curL -ne $null) { "+ ${lineNum}: ${curL}" >> $diffPath }
                      } else {
                          "  ${lineNum}: ${curL}" >> $diffPath
                      }
                 }
                 "..." >> $diffPath
                 $i = $end 
            }
        }
    } else {
         "=== New File (Only in Current): $($file.Name) ===" >> $diffPath
    }
}
