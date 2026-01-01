$diffPath = "c:\Users\cra88y\Dev\Repos\simply-nord\diff_style_only.txt"
$reportPath = "c:\Users\cra88y\Dev\Repos\simply-nord\search_diff_analysis.txt"

$searchLines = Get-Content $diffPath | Where-Object { $_ -match "suggestions" }
$searchLines | Out-File $reportPath

"=== Suggestion diffs found ==="
$searchLines

"Full context saving to $reportPath"
