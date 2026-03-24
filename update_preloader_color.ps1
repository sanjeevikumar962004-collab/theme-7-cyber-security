$dir = "d:\new themes\cyber security"
$files = @("index.html", "about.html", "services.html", "blog.html", "contact.html", "404.html", "forgot.html", "login.html", "signup.html", "admin dasboard.html", "userdashboard.html")

foreach ($file in $files) {
    if (-not $file) { continue }
    $path = Join-Path $dir $file
    if (Test-Path $path) {
        $content = Get-Content $path -Raw -Encoding UTF8

        # We only want to replace #3b82f6 in the preloader styles.
        # However, to be safe and avoid matching other things on the page, 
        # we can target the exact CSS declarations.
        
        $content = $content -replace 'color: #3b82f6;', 'color: #ffffff;'
        $content = $content -replace 'drop-shadow\(0 0 10px #3b82f6\)', 'drop-shadow(0 0 10px #ffffff)'
        $content = $content -replace 'linear-gradient\(to right, transparent, #3b82f6, transparent\)', 'linear-gradient(to right, transparent, #ffffff, transparent)'
        $content = $content -replace 'rgba\(59, 130, 246, 0\.1\)', 'rgba(255, 255, 255, 0.1)'
        $content = $content -replace '2px solid #3b82f6', '2px solid #ffffff'
        $content = $content -replace '0 0 20px #3b82f6', '0 0 20px #ffffff'

        [IO.File]::WriteAllText($path, $content)
        Write-Host "Updated $file"
    }
}
Write-Host "Done patching colors."
