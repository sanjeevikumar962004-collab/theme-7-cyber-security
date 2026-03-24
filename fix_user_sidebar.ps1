$path = "d:\new themes\cyber security\userdashboard.html"
$content = Get-Content $path -Raw -Encoding UTF8

$htmlToInject = @"
    <aside id="sidebar" class="sidebar fixed inset-y-0 left-0 flex flex-col z-40 -translate-x-full lg:translate-x-0 lg:static">
        <div class="pt-10 pb-12 px-8">
            <a href="index.html" class="flex items-center justify-center w-full mt-4 mb-4">
                <img src="whitelogo.webp" alt="Logo" style="width: 160px; height: auto; object-fit: contain;">
            </a>
        </div>

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

        <div class="p-8 border-t border-white/5">
            <div class="flex items-center justify-between mb-4">
                <div class="flex flex-col">
                    <span class="text-[8px] text-gray-500 font-bold uppercase tracking-widest text-nowrap">Operator</span>
                    <span id="user-email-display" class="text-[10px] text-cyan-400 font-medium font-orbitron uppercase" style="text-transform: lowercase;">UNKNOWN</span>
                </div>
                <div class="w-1.5 h-1.5 rounded-full bg-cyan-500 shadow-[0_0_5px_#00f2ff]"></div>
            </div>
        </div>
    </aside>

    <main class="flex-1 flex flex-col relative overflow-y-auto bg-dark">
        
        <header class="flex flex-col md:flex-row items-start md:items-center justify-between p-6 md:p-8 border-b border-white/5 space-y-6 md:space-y-0 z-20">
            <div class="flex items-center space-x-4">
"@

# We match from `<aside id="sidebar"` down to `<div class="flex items-center space-x-4">`
$content = [regex]::Replace($content, '(?s)<aside id="sidebar".*?<div class="flex items-center space-x-4">', $htmlToInject)

[IO.File]::WriteAllText($path, $content)
Write-Host "Restored sidebar and main header tags."
