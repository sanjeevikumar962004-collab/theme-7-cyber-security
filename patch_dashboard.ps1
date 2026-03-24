$dir = "d:\new themes\cyber security"

$files = @("admin dasboard.html", "userdashboard.html")

foreach ($file in $files) {
    if (Test-Path "$dir\$file") {
        $content = Get-Content "$dir\$file" -Raw -Encoding UTF8
        
        # Link logo
        $content = $content -replace '<div class="text-sm font-bold tracking-widest leading-none">(\s*<img src="whitelogo.webp"[^>]*>\s*)</div>', '<a href="index.html" class="text-sm font-bold tracking-widest leading-none">$1</a>'
        
        # Link Home in Sidebar
        $content = $content -replace '<div class="px-4 py-3 bg-white/5 text-white border-l-2 border-cyan-400 cursor-pointer">Home</div>', '<div class="px-4 py-3 bg-white/5 text-white border-l-2 border-cyan-400 cursor-pointer" onclick="window.location.href=''index.html''">Home</div>'
        
        [IO.File]::WriteAllText("$dir\$file", $content)
        Write-Host "Patched $file"
    }
}
Write-Host "Done patching."
