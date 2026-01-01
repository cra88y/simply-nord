$content = Get-Content "C:\Users\cra88y\Dev\Repos\searxng-old-custom-less-backup\client\simple\src\less\style.less"
$inBlock = $false
$braceCount = 0

foreach ($line in $content) {
    if ($line -match "^\.result-images \{") {
        $inBlock = $true
        $braceCount = 0
    }
    
    if ($inBlock) {
        Write-Host $line
        $braceCount += ([char[]]$line | Where-Object { $_ -eq '{' }).Count
        $braceCount -= ([char[]]$line | Where-Object { $_ -eq '}' }).Count
        
        if ($braceCount -eq 0 -and $line -match "\}") {
            $inBlock = $false
        }
    }
}
