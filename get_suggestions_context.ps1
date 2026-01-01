$diffPath = "c:\Users\cra88y\Dev\Repos\simply-nord\diff_style_only.txt"
$content = Get-Content $diffPath
$output = @()

for ($i = 0; $i -lt $content.Count; $i++) {
    if ($content[$i] -match "suggestions") {
        $start = [Math]::Max(0, $i - 10)
        $end = [Math]::Min($content.Count - 1, $i + 20)
        $output += "Match at line $i : $($content[$i])"
        $output += $content[$start..$end]
        $output += "----------------------------------------"
    }
}
$output | Out-File "c:\Users\cra88y\Dev\Repos\simply-nord\search_suggestions_context_fixed.txt"
