$files = @(
    "d:\new themes\cyber security\admin dasboard.html",
    "d:\new themes\cyber security\userdashboard.html"
)

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -Encoding UTF8
        
        # HTML Utility Classes
        $content = $content -replace 'text-cyan-\d+', 'text-white'
        $content = $content -replace 'text-green-\d+', 'text-gray-300'
        $content = $content -replace 'text-red-\d+', 'text-gray-400'
        
        $content = $content -replace 'bg-cyan-\d+(/\d+)?', 'bg-white/10'
        $content = $content -replace 'bg-green-\d+(/\d+)?', 'bg-white/5'
        $content = $content -replace 'bg-red-\d+(/\d+)?', 'bg-white/5'

        $content = $content -replace 'border-cyan-\d+(/\d+)?', 'border-white/20'
        $content = $content -replace 'border-green-\d+(/\d+)?', 'border-white/20'
        $content = $content -replace 'border-red-\d+(/\d+)?', 'border-white/20'

        $content = $content -replace 'glow-(cyan|green|red)', 'glow-white'

        # Inject .glow-white css rule if missing
        if ($content -notmatch '\.glow-white') {
            $content = $content -replace '</style>', ".glow-white { filter: drop-shadow(0 0 8px rgba(255,255,255,0.7)); }`n</style>"
        }

        # CSS Variables for components (like .nav-item.active)
        $content = $content -replace 'var\(--accent-(cyan|green|red)\)', '#ffffff'
        
        # Chart.js and SVG script colors
        $content = $content -replace "'#00f2ff'", "'#ffffff'"
        $content = $content -replace '"#00f2ff"', '"#ffffff"'
        $content = $content -replace 'rgba\(0, 242, 255,', 'rgba(255, 255, 255,'
        
        $content = $content -replace "'#00ffcc'", "'#cccccc'"
        $content = $content -replace '"#00ffcc"', '"#cccccc"'

        $content = $content -replace "'#ff4b5c'", "'#666666'"
        $content = $content -replace '"#ff4b5c"', '"#666666"'
        
        # Some specific cases in admin dashboard charts
        $content = $content -replace "\['#00f2ff', '#00ffcc', '#ff4b5c'\]", "['#ffffff', '#cccccc', '#666666']"
        $content = $content -replace "color: '#00f2ff'", "color: '#ffffff'"

        # Apply specific responsive fix to Admin Dashboard <main> tag to block lateral spilling
        if ($file -match "admin dasboard.html") {
            $content = $content -replace '<main class="([^"]*)">', '<main class="$1 overflow-x-hidden">'
        }

        [IO.File]::WriteAllText($file, $content)
    }
}
Write-Host "Monochrome modifications applied successfully."
