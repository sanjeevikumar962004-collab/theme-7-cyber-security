$dir = "d:\new themes\cyber security"

Get-ChildItem -Path $dir -Filter *.html | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding UTF8
    
    # Fix footer links
    $content = $content -replace '<li><a href="404\.html">Home</a></li>', '<li><a href="index.html">Home</a></li>'
    $content = $content -replace '<li><a href="404\.html">About</a></li>', '<li><a href="about.html">About</a></li>'
    $content = $content -replace '<li><a href="404\.html">Services</a></li>', '<li><a href="services.html">Services</a></li>'
    $content = $content -replace '<li><a href="404\.html">Blog</a></li>', '<li><a href="blog.html">Blog</a></li>'
    $content = $content -replace '<li><a href="404\.html">Contact</a></li>', '<li><a href="contact.html">Contact</a></li>'

    $content = $content -replace '<li><a href="#">Home</a></li>', '<li><a href="index.html">Home</a></li>'
    $content = $content -replace '<li><a href="#">About</a></li>', '<li><a href="about.html">About</a></li>'
    $content = $content -replace '<li><a href="#">Services</a></li>', '<li><a href="services.html">Services</a></li>'
    $content = $content -replace '<li><a href="#">Blog</a></li>', '<li><a href="blog.html">Blog</a></li>'
    $content = $content -replace '<li><a href="#">Contact</a></li>', '<li><a href="contact.html">Contact</a></li>'

    [IO.File]::WriteAllText($_.FullName, $content)
    Write-Host "Patched $($_.Name)"
}
Write-Host "Done patching."
