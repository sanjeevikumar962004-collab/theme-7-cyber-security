$path = "d:\new themes\cyber security\userdashboard.html"
$content = Get-Content $path -Raw -Encoding UTF8

$cssBlock = @"
        .nav-item {
            display: flex;
            align-items: center;
            padding: 12px 28px;
            color: var(--text-dim);
            font-size: 11px;
            font-weight: 500;
            letter-spacing: 0.05em;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            position: relative;
        }

        .nav-item svg {
            margin-right: 14px;
            width: 18px;
            height: 18px;
            stroke-width: 1.5px;
            transition: all 0.3s ease;
        }

        .nav-item:hover { color: #ffffff; }
        .nav-item:hover svg { transform: translateX(2px); color: var(--accent-cyan); }
        .nav-item.active { color: #ffffff; }
        .nav-item.active::before {
            content: '';
            position: absolute;
            left: 0;
            top: 25%;
            height: 50%;
            width: 2px;
            background: var(--accent-cyan);
            box-shadow: 0 0 10px var(--accent-cyan);
        }
        .nav-item.active svg { color: var(--accent-cyan); filter: drop-shadow(0 0 5px rgba(0, 242, 255, 0.5)); }

/* PRELOADER STYLES */
"@

# Inject CSS block
$content = $content -replace '/\* PRELOADER STYLES \*/', $cssBlock

$navPattern = '(?s)<nav class="flex-1.*?<\/nav>'

$newNav = @"
        <nav class="flex-1 space-y-1">
            <div class="nav-item active" onclick="window.location.href='index.html'">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" /></svg>
                Home
            </div>
            <div class="nav-item" onclick="window.location.href='404.html'">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" /></svg>
                Processes
            </div>
            <div class="nav-item" onclick="window.location.href='404.html'">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" /></svg>
                Tools
            </div>
            <div class="nav-item" onclick="window.location.href='404.html'">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" /></svg>
                Coverage
            </div>
            <div class="nav-item" onclick="window.location.href='404.html'">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" /></svg>
                Compliance
            </div>
        </nav>
"@

$content = $content -replace $navPattern, $newNav
[IO.File]::WriteAllText($path, $content)
Write-Host "Sidebar updated in userdashboard.html"
