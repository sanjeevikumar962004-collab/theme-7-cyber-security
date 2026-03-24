$adminPath = "d:\new themes\cyber security\admin dasboard.html"
$userPath = "d:\new themes\cyber security\userdashboard.html"

foreach ($path in @($adminPath, $userPath)) {
    $content = Get-Content $path -Raw -Encoding UTF8

    # 1. Strip existing onclick from nav-items
    $content = [regex]::Replace($content, 'class="(nav-item\s*active|nav-item)"\s*onclick="[^"]*"', 'class="$1"')
    
    # 2. Add onclick to nav-items
    $content = [regex]::Replace($content, 'class="(nav-item\s*active|nav-item)"', 'class="$1" onclick="window.location.href=''404.html''"')

    # 3. Add Logout to bottom of nav
    $logoutHtml = @"
            <div class="h-8"></div>
            <div class="nav-item text-red-500 hover:bg-red-500/10 hover:text-red-400" onclick="window.location.href='index.html'">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" /></svg>
                Logout
            </div>
        </nav>
"@
    $content = [regex]::Replace($content, '(?s)\s*</nav>', "`n$logoutHtml")

    # 4. Modify 'Export Report' buttons or any primary button
    $content = [regex]::Replace($content, '(?s)<button([^>]*)class="(bg-blue-600[^"]*|.*bg-blue-600.*)"([^>]*)>', '<button$1class="$2" onclick="window.location.href=''404.html''"$3>')

    [IO.File]::WriteAllText($path, $content)
}

# 5. Add 2 nodes to admin dasboard.html
$adminContent = Get-Content $adminPath -Raw -Encoding UTF8
$extraNodes = @"
                        <div class="node-item flex items-center space-x-4 bg-white/5 p-4 rounded-full border border-white/5 hover:bg-white/10 transition-all cursor-pointer group" data-color="green">
                            <div class="w-10 h-10 rounded-full border-2 border-green-400 flex items-center justify-center text-green-400 font-bold text-xs glow-green">77</div>
                            <div class="flex-1 text-xs font-semibold group-hover:text-cyan-400 transition-colors uppercase">System Protocol</div>
                            <div class="text-green-500 text-[10px] font-bold uppercase">Safe</div>
                        </div>
                        <div class="node-item flex items-center space-x-4 bg-white/5 p-4 rounded-full border border-white/5 hover:bg-white/10 transition-all cursor-pointer group" data-color="green">
                            <div class="w-10 h-10 rounded-full border-2 border-green-400 flex items-center justify-center text-green-400 font-bold text-xs glow-green">88</div>
                            <div class="flex-1 text-xs font-semibold group-hover:text-cyan-400 transition-colors uppercase">Firewall</div>
                            <div class="text-green-500 text-[10px] font-bold uppercase">Safe</div>
                        </div>
"@
$adminContent = [regex]::Replace($adminContent, '(?s)<div class="text-red-500 text-\[10px\] font-bold uppercase">Alert</div>\s*</div>', "`$0`n$extraNodes")
[IO.File]::WriteAllText($adminPath, $adminContent)
Write-Host "Updated UI."
