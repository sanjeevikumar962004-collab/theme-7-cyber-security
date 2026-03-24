$dir = "d:\new themes\cyber security"
$files = @("about.html", "services.html", "blog.html", "contact.html", "404.html", "forgot.html", "login.html", "signup.html", "admin dasboard.html", "userdashboard.html")

$headerReplacement = @"
        <div class="nav-links">
            <a href="index.html" class="magnetic-elem">Home</a>
            <a href="about.html" class="magnetic-elem">About</a>
            <a href="services.html" class="magnetic-elem">Services</a>
            <a href="blog.html" class="magnetic-elem">Blog</a>
            <a href="contact.html" class="magnetic-elem">Contact</a>
        </div>
"@

$mobileReplacement = @"
        <nav class="mobile-nav">
            <a href="index.html">Home</a>
            <a href="about.html">About</a>
            <a href="services.html">Services</a>
            <a href="blog.html">Blog</a>
            <a href="contact.html">Contact</a>
            <a href="login.html" style="color: var(--text-white); font-weight: 500; font-size: 1.2rem; margin-top: 40px; border-bottom: 1px solid var(--text-white); padding-bottom: 8px;">Login</a>
        </nav>
"@

$footerReplacement = @"
                    <ul class="footer-links">
                        <li><a href="index.html">Home</a></li>
                        <li><a href="about.html">About</a></li>
                        <li><a href="services.html">Services</a></li>
                        <li><a href="blog.html">Blog</a></li>
                        <li><a href="contact.html">Contact</a></li>
                    </ul>
"@

foreach ($file in $files) {
    if (-not $file) { continue }
    $path = Join-Path $dir $file
    if (Test-Path $path) {
        $content = Get-Content $path -Raw -Encoding UTF8
        
        # Regex for header nav
        $content = $content -replace '(?s)<div class="nav-links">.*?</div>', $headerReplacement
        
        # Regex for mobile nav
        $content = $content -replace '(?s)<nav class="mobile-nav">.*?</nav>', $mobileReplacement
        
        # Regex for footer links
        $content = $content -replace '(?s)<ul class="footer-links">.*?</ul>', $footerReplacement
        
        # Add active state styles
        if ($file -eq "about.html") {
            $content = $content -replace '<a href="about.html" class="magnetic-elem">', '<a href="about.html" class="magnetic-elem" style="color: var(--text-white);">'
        } elseif ($file -eq "services.html") {
            $content = $content -replace '<a href="services.html" class="magnetic-elem">', '<a href="services.html" class="magnetic-elem" style="color: var(--text-white);">'
        } elseif ($file -eq "blog.html") {
            $content = $content -replace '<a href="blog.html" class="magnetic-elem">', '<a href="blog.html" class="magnetic-elem" style="color: var(--text-white);">'
        } elseif ($file -eq "contact.html") {
            $content = $content -replace '<a href="contact.html" class="magnetic-elem">', '<a href="contact.html" class="magnetic-elem" style="color: var(--text-white);">'
        }
        
        [IO.File]::WriteAllText($path, $content)
        Write-Host "Patched $file"
    } else {
        Write-Host "File not found: $file"
    }
}
Write-Host "Done patching."
