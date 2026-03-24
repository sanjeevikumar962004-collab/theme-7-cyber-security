$htmlFiles = Get-ChildItem -Path "d:\new themes\cyber security" -Filter "*.html" | Select-Object -ExpandProperty FullName

foreach ($file in $htmlFiles) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -Encoding UTF8
        
        # 1. globally reduce the static 160px logo width to 130px
        $content = $content -replace 'style="width:\s*160px;', 'style="width: 130px;'

        # 2. slider responsiveness patches
        if ($content -match '\.slide-info--text') {
            # Strip strict nowrap which tears mobile screens
            $content = $content -replace 'white-space:\s*nowrap;', 'white-space: normal; line-height: 1.1;'
            
            # Reduce minimum clamp thresholds for extreme mobile
            $content = $content -replace 'clamp\(1\.5rem,\s*6vw,\s*2\.4rem\)', 'clamp(1.2rem, 5vw, 2.4rem)'
            $content = $content -replace 'clamp\(1\.2rem,\s*4vw,\s*1\.8rem\)', 'clamp(1rem, 4vw, 1.8rem)'
        }

        [IO.File]::WriteAllText($file, $content)
    }
}
Write-Host "Logos compressed. Slider texts updated into elastic containers."
