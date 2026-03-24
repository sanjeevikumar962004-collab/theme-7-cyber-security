$path = "d:\new themes\cyber security\userdashboard.html"
$content = Get-Content $path -Raw -Encoding UTF8

$targetPattern = '(?s)<div class="stat-card p-4 md:p-6 rounded-2xl flex flex-col items-center justify-center shadow-lg">\s*<span class="text-gray-500 text-\[8px\] md:text-\[10px\] uppercase font-bold tracking-widest mb-2">Sys Health</span>.*?counter\.innerText = target;\s*\}\s*\};\s*updateCount\(\);\s*\}\);'

$replacement = @"
                <div class="stat-card p-4 md:p-6 rounded-2xl flex flex-col items-center justify-center shadow-lg">
                    <span class="text-gray-500 text-[8px] md:text-[10px] uppercase font-bold tracking-widest mb-2">Sys Health</span>
                    <div class="flex items-center space-x-2">
                        <div class="w-2 h-2 md:w-3 md:h-3 bg-green-500 rounded-full animate-pulse shadow-[0_0_10px_#22c55e]"></div>
                        <span class="text-xs md:text-xl font-orbitron font-bold">OPTIMAL</span>
                    </div>
                </div>
            </div>

        </div>

        <div class="absolute inset-0 pointer-events-none opacity-[0.03] -z-10" style="background-image: radial-gradient(#fff 1px, transparent 1px); background-size: 40px 40px;"></div>
    </main>

    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const sidebar = document.getElementById('sidebar');
            const openBtn = document.getElementById('open-menu');
            const closeBtn = document.getElementById('close-menu');
            const overlay = document.getElementById('mobile-overlay');

            const toggleMenu = () => {
                if (sidebar) sidebar.classList.toggle('-translate-x-full');
                if (overlay) overlay.classList.toggle('active');
            };

            if (openBtn) openBtn.addEventListener('click', toggleMenu);
            if (closeBtn) closeBtn.addEventListener('click', toggleMenu);
            if (overlay) overlay.addEventListener('click', toggleMenu);

            const counters = document.querySelectorAll('.counter');
            counters.forEach(counter => {
                const target = +counter.getAttribute('data-target');
                const duration = 2000;
                const increment = target / (duration / 16);
                
                let current = 0;
                const updateCount = () => {
                    current += increment;
                    if (current < target) {
                        counter.innerText = Math.ceil(current);
                        requestAnimationFrame(updateCount);
                    } else {
                        counter.innerText = target;
                    }
                };
                updateCount();
            });
"@

$content = [regex]::Replace($content, $targetPattern, $replacement)
[IO.File]::WriteAllText($path, $content)
Write-Host "Replaced properly"
