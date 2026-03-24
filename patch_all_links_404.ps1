$dir = "d:\new themes\cyber security"
Get-ChildItem -Path $dir -Filter *.html | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding UTF8
    
    # Replace normal nav links with 404
    $content = $content -replace 'href="about\.html"', 'href="404.html"'
    $content = $content -replace 'href="services\.html"', 'href="404.html"'
    $content = $content -replace 'href="blog\.html"', 'href="404.html"'
    $content = $content -replace 'href="contact\.html"', 'href="404.html"'
    
    # Also Home links (but preserve index.html on nav-logo and user-logo)
    $content = $content -replace '<a href="index\.html" class="magnetic-elem"(:? style="color: var\(--text-white\);")?>Home</a>', '<a href="404.html" class="magnetic-elem"$1>Home</a>'
    $content = $content -replace '<a href="index\.html">Home</a>', '<a href="404.html">Home</a>'
    
    # Buttons
    $content = $content -replace '<button class="btn-solid magnetic-elem">\s*Request Audit\s*</button>', '<button class="btn-solid magnetic-elem" onclick="window.location.href=''404.html''">Request Audit</button>'
    $content = $content -replace '<button class="btn-pricing basic">\s*Deploy Starter\s*</button>', '<button class="btn-pricing basic" onclick="window.location.href=''404.html''">Deploy Starter</button>'
    $content = $content -replace '<button class="btn-pricing pro">\s*Deploy Shield\s*</button>', '<button class="btn-pricing pro" onclick="window.location.href=''404.html''">Deploy Shield</button>'
    $content = $content -replace '<button class="btn-pricing basic">\s*Contact Sales\s*</button>', '<button class="btn-pricing basic" onclick="window.location.href=''404.html''">Contact Sales</button>'
    $content = $content -replace '<button class="btn-solid magnetic-elem">\s*Contact Sales\s*', '<button class="btn-solid magnetic-elem" onclick="window.location.href=''404.html''">Contact Sales '

    # Dashboard specific links
    $content = $content -replace 'class="px-4 py-3 text-gray-500 hover:text-white hover:bg-white/5 transition cursor-pointer">Processes', 'class="px-4 py-3 text-gray-500 hover:text-white hover:bg-white/5 transition cursor-pointer" onclick="window.location.href=''404.html''">Processes'
    $content = $content -replace 'class="px-4 py-3 text-gray-500 hover:text-white hover:bg-white/5 transition cursor-pointer">Tools', 'class="px-4 py-3 text-gray-500 hover:text-white hover:bg-white/5 transition cursor-pointer" onclick="window.location.href=''404.html''">Tools'
    $content = $content -replace 'class="px-4 py-3 text-gray-500 hover:text-white hover:bg-white/5 transition cursor-pointer">Coverage', 'class="px-4 py-3 text-gray-500 hover:text-white hover:bg-white/5 transition cursor-pointer" onclick="window.location.href=''404.html''">Coverage'
    $content = $content -replace 'class="px-4 py-3 text-gray-500 hover:text-white hover:bg-white/5 transition cursor-pointer">Compliance', 'class="px-4 py-3 text-gray-500 hover:text-white hover:bg-white/5 transition cursor-pointer" onclick="window.location.href=''404.html''">Compliance'

    [IO.File]::WriteAllText($_.FullName, $content)
    Write-Host "Patched $($_.Name)"
}
Write-Host "Done patching."
