$dir = "d:\new themes\cyber security"
$files = @("index.html", "about.html", "services.html", "blog.html", "contact.html", "404.html", "forgot.html", "login.html", "signup.html", "admin dasboard.html", "userdashboard.html")

$preloaderHTML = @"
<div id="global-preloader" class="preloader-overlay">
  <div class="fingerprint-container">
    <svg viewBox="0 0 256 256" height="256" width="256" xmlns="http://www.w3.org/2000/svg" class="fingerprint-svg">
      <path d="M126.42 24C70.73 24.85 25.21 70.09 24 125.81a103.53 103.53 0 0 0 13.52 53.54a4 4 0 0 0 7.1-.3a119.35 119.35 0 0 0 11.37-51A71.77 71.77 0 0 1 83 71.83a8 8 0 1 1 9.86 12.61A55.82 55.82 0 0 0 72 128.07a135.3 135.3 0 0 1-18.45 68.35a4 4 0 0 0 .61 4.85c2 2 4.09 4 6.25 5.82a4 4 0 0 0 6-1A151.2 151.2 0 0 0 85 158.49a8 8 0 1 1 15.68 3.19a167.3 167.3 0 0 1-21.07 53.64a4 4 0 0 0 1.6 5.63c2.47 1.25 5 2.41 7.57 3.47a4 4 0 0 0 5-1.61A183 183 0 0 0 120 128.28a8.16 8.16 0 0 1 7.44-8.21a8 8 0 0 1 8.56 8a198.94 198.94 0 0 1-25.21 97.16a4 4 0 0 0 2.95 5.92q4.55.63 9.21.86a4 4 0 0 0 3.67-2.1A214.9 214.9 0 0 0 152 128.8c.05-13.25-10.3-24.49-23.54-24.74A24 24 0 0 0 104 128a8.1 8.1 0 0 1-7.29 8a8 8 0 0 1-8.71-8a40 40 0 0 1 40.42-40c22 .23 39.68 19.17 39.57 41.16a231.4 231.4 0 0 1-20.52 94.57a4 4 0 0 0 4.62 5.51a104 104 0 0 0 10.26-3a4 4 0 0 0 2.35-2.22a244 244 0 0 0 11.48-34a8 8 0 1 1 15.5 4q-1.12 4.37-2.4 8.7a4 4 0 0 0 6.46 4.17A104 104 0 0 0 126.42 24M198 161.08a8 8 0 0 1-7.92 7a8 8 0 0 1-1-.06a8 8 0 0 1-6.95-8.93a253 253 0 0 0 1.92-31a56.08 56.08 0 0 0-56-56a57 57 0 0 0-7 .43a8 8 0 0 1-2-15.89a72.1 72.1 0 0 1 81 71.49a267 267 0 0 1-2.05 32.96" stroke-width="1" stroke="currentColor" fill="currentColor" class="fingerprint-path"></path>
    </svg>
    <div class="scan-line"></div>
    <div class="matrix-rain"></div>
    <div class="ripple1"></div>
    <div class="ripple2"></div>
    <div class="ripple3"></div>
    <div class="glow"></div>
    <div class="status">Authenticating...</div>
  </div>
</div>
"@

$preloaderCSS = @"
<style>
/* PRELOADER STYLES */
.preloader-overlay {
    position: fixed; top: 0; left: 0; width: 100%; height: 100%;
    background: #000000; z-index: 999999;
    display: flex; justify-content: center; align-items: center;
    transition: opacity 0.5s ease-out, visibility 0.5s ease-out;
}
.preloader-hidden { opacity: 0; visibility: hidden; pointer-events: none; }

.fingerprint-container {
  position: relative;
  width: 160px;
  height: 160px;
  animation: flicker 3s infinite ease-in-out;
  border-radius: 50%;
}

.fingerprint-svg {
  width: 100%;
  height: 100%;
  color: #3b82f6;
  filter: drop-shadow(0 0 10px #3b82f6);
  transform: scale(1.1);
  transition: transform 0.2s ease, filter 0.3s ease;
}

.fingerprint-path {
  stroke-dasharray: 500;
  stroke-dashoffset: 0;
  animation: draw 4s infinite linear;
}

.scan-line {
  position: absolute; top: 0; left: 0; width: 100%; height: 3px;
  background: linear-gradient(to right, transparent, #3b82f6, transparent);
  animation: scan 1s infinite linear;
  opacity: 0.7;
}

.matrix-rain {
  position: absolute; width: 100%; height: 100%; top: 0; left: 0;
  opacity: 0.5; background: linear-gradient(to bottom, rgba(59, 130, 246, 0.1), transparent);
  overflow: hidden; border-radius: 50%;
}

.matrix-rain::before {
  content: "101010 1100 0011 0101 1001 1110 0010 1101";
  position: absolute; color: #3b82f6; font-size: 14px; opacity: 0.2;
  animation: rain 1.5s infinite linear;
}

.ripple1, .ripple2, .ripple3 {
  position: absolute; width: 100%; height: 100%; top: 0; left: 0;
  border-radius: 50%; border: 2px solid #3b82f6; opacity: 0; transform: scale(0);
}

.glow {
  position: absolute; width: 100%; height: 100%; top: 0; left: 0;
  border-radius: 50%; box-shadow: 0 0 20px #3b82f6; opacity: 0;
}

.status {
  position: absolute; bottom: -30px; width: 100%; text-align: center;
  color: #3b82f6; font-size: 16px; opacity: 0.7; text-transform: uppercase;
  letter-spacing: 2px; animation: glitch-text 2s infinite;
}

/* Animations */
@keyframes flicker { 0%, 100% { opacity: 1; } 50% { opacity: 0.9; } 75% { opacity: 0.95; } }
@keyframes draw { 0% { stroke-dashoffset: 500; } 100% { stroke-dashoffset: 0; } }
@keyframes scan { 0% { transform: translateY(0); opacity: 0.7; } 50% { opacity: 1; } 100% { transform: translateY(200px); opacity: 0.7; } }
@keyframes rain { 0% { transform: translateY(-100%); } 100% { transform: translateY(100%); } }
@keyframes glitch-text { 0% { transform: translate(0); } 20% { transform: translate(-1px, 1px); } 40% { transform: translate(1px, -1px); } 60% { transform: translate(-1px, 0); } 80% { transform: translate(1px, 0); } 100% { transform: translate(0); } }
</style>
"@

$preloaderJS = @"
<script>
    document.addEventListener("DOMContentLoaded", () => {
        const preloader = document.getElementById('global-preloader');
        if(!preloader) return;
        const minTime = 2000;
        const startTime = Date.now();
        
        const hidePreloader = () => {
            const elapsedTime = Date.now() - startTime;
            const remainingTime = Math.max(0, minTime - elapsedTime);
            setTimeout(() => {
                preloader.classList.add('preloader-hidden');
            }, remainingTime);
        };

        if (document.readyState === 'complete') {
            hidePreloader();
        } else {
            window.addEventListener('load', hidePreloader);
        }
    });
</script>
"@

$footerLogoPattern = '(?s)<div class="nav-logo" style="margin-bottom: 32px;">\s*<img src="whitelogo.webp" class="nav-logo-icon" alt="Logo" style="width: 160px; height: auto; object-fit: contain; "></div>'
$footerLogoReplacement = '<a href="index.html" class="nav-logo" style="margin-bottom: 32px; display: block;"><img src="whitelogo.webp" class="nav-logo-icon" alt="Logo" style="width: 160px; height: auto; object-fit: contain;"></a>'

foreach ($file in $files) {
    if (-not $file) { continue }
    $path = Join-Path $dir $file
    if (Test-Path $path) {
        $content = Get-Content $path -Raw -Encoding UTF8

        # 1. Update footer logo
        $content = $content -replace $footerLogoPattern, $footerLogoReplacement

        # Some pages like admin or user dashboard might not have the standard footer, 
        # but if they do it gets replaced. Auth pages don't have this footer.

        # 2. Check if preloader already exists
        if ($content -notmatch '<div id="global-preloader"') {
            # Inject CSS before </head>
            $content = $content -replace '(?s)</head>', "`n$preloaderCSS`n</head>"
            
            # Inject HTML right after <body> or <body class="...">
            $content = $content -replace '(?s)(<body[^>]*>)', "`$1`n$preloaderHTML"
            
            # Inject JS before </body>
            $content = $content -replace '(?s)</body>', "`n$preloaderJS`n</body>"
        }

        [IO.File]::WriteAllText($path, $content)
        Write-Host "Injected preloader to $file"
    }
}
Write-Host "Done patching preloader."
