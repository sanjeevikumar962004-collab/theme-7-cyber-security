$dir = "d:\new themes\cyber security"
Get-ChildItem -Path $dir -Filter *.html | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding UTF8
    
    $content = $content -replace '(?s)<style>\s*:root\[data-theme="light"\] \.nav-logo-icon\s*\{\s*filter:\s*invert\(1\);\s*\}\s*</style>\r?\n?', ''
    $content = $content.replace('src="stackly.webp"', 'src="whitelogo.webp"')
    $content = $content -replace '(?s)filter:\s*drop-shadow\(0 0 5px #00f2ff\);?\s*', ''
    $content = $content -replace '(?s)(<img[^>]*src="whitelogo\.webp"[^>]*>)\s*Stackly\b', '$1'
    $content = $content.replace('alt="Stackly Logo"', 'alt="Logo"')

    # Fix footer huge brand text
    $content = $content -replace '(?s)<div class="footer-brand-huge">STACKLY</div>', '<div class="footer-brand-huge">LOGOTEXT</div>'

    [IO.File]::WriteAllText($_.FullName, $content)
    Write-Host "Processed: $($_.Name)"
}
Write-Host "Done"
