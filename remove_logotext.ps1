$dir = "d:\new themes\cyber security"
Get-ChildItem -Path $dir -Filter *.html | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding UTF8
    
    if ($content -match 'LOGOTEXT') {
        $content = $content.Replace('<div class="footer-brand-huge">LOGOTEXT</div>', '')
        [IO.File]::WriteAllText($_.FullName, $content)
        Write-Host "Updated $($_.Name)"
    }
}
Write-Host "Done"
