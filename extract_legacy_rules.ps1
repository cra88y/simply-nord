$legacyStyle = "C:\Users\cra88y\Dev\Repos\searxng-old-custom-less-backup\client\simple\src\less\style.less"
$selectors = @("#suggestions", "#answers", ".result", ".infobox", "#results", "#search_header", ".search_filters", "#urls")

foreach ($selector in $selectors) {
    "=== Rules for $selector ==="
    # This is a bit complex as selectors can be nested. 
    # We'll just grep for the selector and show some lines after.
    Get-Content $legacyStyle | Select-String -Pattern "^$selector" -Context 0,30 | Select-Object -First 1
    "---------------------------"
}
