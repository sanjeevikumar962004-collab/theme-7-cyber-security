$dir = "d:\new themes\cyber security"
$htmlFiles = Get-ChildItem -Path $dir -Filter "*.html"

$imageDir = Join-Path $dir "images"
$localImages = @()
if (Test-Path $imageDir) {
    $localImages = Get-ChildItem -Path $imageDir -Include *.webp, *.jpg, *.png -Recurse | Select-Object -ExpandProperty Name
}

foreach ($file in $htmlFiles) {
    $originalContent = Get-Content $file.FullName -Raw -Encoding UTF8
    if ([string]::IsNullOrWhiteSpace($originalContent)) { continue }
    
    $content = $originalContent
    
    # 1. Replace Logo
    $svgRegex = '(?s)<svg class="nav-logo-icon".*?</svg>'
    $newLogo = '<img src="stackly.webp" class="nav-logo-icon" alt="Stackly Logo" style="width: 24px; height: 24px; object-fit: contain;">'
    $content = $content -replace $svgRegex, $newLogo
    
    # 2. Replace Unsplash URLs
    if ($localImages.Count -gt 0) {
        $unsplashRegex = [regex]'https://images\.unsplash\.com/[^"''\)\s]+'
        $match = $unsplashRegex.Match($content)
        while ($match.Success) {
            $randomImg = Get-Random -InputObject $localImages
            $replacement = "images/$randomImg"
            $content = $content.Replace($match.Value, $replacement)
            $match = $unsplashRegex.Match($content)
        }
    }
    
    # 3. Replace "Sign In" with "Login"
    $content = $content -replace '>Sign In<', '>Login<'
    
    if ($content -cne $originalContent) {
        # Using UTF8 without BOM
        $utf8NoBom = New-Object System.Text.UTF8Encoding $false
        [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
        Write-Host "Updated $($file.Name)"
    }
}
