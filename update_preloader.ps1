$dir = "d:\new themes\cyber security"
$files = @("index.html", "about.html", "services.html", "blog.html", "contact.html", "404.html", "forgot.html", "login.html", "signup.html", "admin dasboard.html", "userdashboard.html")

$lightModeCSS = @"
/* Light Mode Preloader Overrides */
:root[data-theme="light"] .preloader-overlay { background: #ffffff; }
:root[data-theme="light"] .fingerprint-svg { color: #000000; filter: drop-shadow(0 0 10px #000000); }
:root[data-theme="light"] .scan-line { background: linear-gradient(to right, transparent, #000000, transparent); opacity: 0.4; }
:root[data-theme="light"] .matrix-rain { background: linear-gradient(to bottom, rgba(0, 0, 0, 0.1), transparent); }
:root[data-theme="light"] .matrix-rain::before { color: #000000; }
:root[data-theme="light"] .ripple1, :root[data-theme="light"] .ripple2, :root[data-theme="light"] .ripple3 { border: 2px solid #000000; }
:root[data-theme="light"] .glow { box-shadow: 0 0 20px #000000; opacity: 0; }
:root[data-theme="light"] .status { color: #000000; }
</style>
"@

foreach ($file in $files) {
    if (-not $file) { continue }
    $path = Join-Path $dir $file
    if (Test-Path $path) {
        $content = Get-Content $path -Raw -Encoding UTF8

        # Replace text
        $content = $content -replace '<div class="status">Authenticating...</div>', '<div class="status">Loading...</div>'
        
        # Inject Light Mode CSS just before the end of the preloader styles
        if ($content -notmatch 'Light Mode Preloader Overrides') {
            $content = $content -replace '(?s)@keyframes glitch-text {.*?}</style>', "`$$&`n$lightModeCSS"
            # Wait, the Regex `(?s)@keyframes glitch-text {.*?}</style>` matches anything down to the end.
            # Instead, I can just replace `100% { transform: translate(0); } }`
            $content = $content -replace '(?s)100% \{ transform: translate\(0\); \} \}`n</style>', "100% { transform: translate(0); } }`n$lightModeCSS"
        }
        
        [IO.File]::WriteAllText($path, $content)
        Write-Host "Updated $file"
    }
}
Write-Host "Done updating."
