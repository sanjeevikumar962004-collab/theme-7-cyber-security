$path = "d:\new themes\cyber security\userdashboard.html"
$content = Get-Content $path -Raw -Encoding UTF8

$content = $content -replace '<div class="text-5xl md:text-8xl font-orbitron font-bold counter" data-target="73">0</div>', '<div id="healthPercentage" class="text-5xl md:text-8xl font-orbitron font-bold">0</div>'

$jsTarget = '(?s)const mainGauge = document\.getElementById\(''mainGauge''\);.*?setTimeout\(drawConnections, 850\);'

$newJs = @'
            // FIXED GAUGE ANIMATION: Loading forward from 0 to target
            const animateGauge = () => {
                const mainGauge = document.getElementById('mainGauge');
                const healthText = document.getElementById('healthPercentage');
                if (!mainGauge) return;
                
                const targetValue = 73;
                const radius = 160;
                const circumference = 2 * Math.PI * radius;
                
                // Initialize as empty
                mainGauge.style.strokeDasharray = `${circumference} ${circumference}`;
                mainGauge.style.strokeDashoffset = circumference;
                
                const finalOffset = circumference - (targetValue / 100) * circumference;
                
                // Animate text counter synced with ring
                let currentVal = 0;
                const duration = 2500; // Match CSS transition
                const startTime = performance.now();

                const updateText = (timestamp) => {
                    const elapsed = timestamp - startTime;
                    const progress = Math.min(elapsed / duration, 1);
                    // Easing function (easeOutCubic)
                    const easedProgress = 1 - Math.pow(1 - progress, 3);
                    
                    currentVal = Math.floor(easedProgress * targetValue);
                    if(healthText) healthText.innerText = currentVal;

                    if (progress < 1) {
                        requestAnimationFrame(updateText);
                    } else {
                        if(healthText) healthText.innerText = targetValue;
                    }
                };

                // Trigger animations
                requestAnimationFrame(() => {
                    setTimeout(() => {
                        mainGauge.style.strokeDashoffset = finalOffset;
                        requestAnimationFrame(updateText);
                    }, 100);
                });
            };
            
            animateGauge();

            // Connectivity Lines
            const drawConnections = () => {
                const svg = document.getElementById('connectionContainer');
                const gaugeContainer = document.getElementById('gaugeContainer');
                if (!svg || !gaugeContainer || window.innerWidth < 1280) return;

                const nodes = document.querySelectorAll('.node-item');
                const containerRect = svg.getBoundingClientRect();
                const gaugeRect = gaugeContainer.getBoundingClientRect();
                
                svg.innerHTML = ''; 

                const startX = gaugeRect.left + (gaugeRect.width * 0.88) - containerRect.left;
                const centerY = (gaugeRect.top + gaugeRect.bottom) / 2 - containerRect.top;

                nodes.forEach((node, index) => {
                    const rect = node.getBoundingClientRect();
                    const endX = (rect.left - containerRect.left) + 20;
                    const endY = (rect.top + rect.bottom) / 2 - containerRect.top;
                    
                    const originYOffset = (index - 1) * 15; 
                    const startY = centerY + originYOffset;

                    const path = document.createElementNS("http://www.w3.org/2000/svg", "path");
                    const color = node.getAttribute('data-color') === 'red' ? '#ff4b5c' : '#61fcc3';
                    const midX = startX + (endX - startX) * 0.45;
                    const d = `M ${startX} ${startY} C ${midX} ${startY}, ${midX} ${endY}, ${endX} ${endY}`;
                    
                    path.setAttribute("d", d);
                    path.setAttribute("fill", "none");
                    path.setAttribute("stroke", color);
                    path.setAttribute("stroke-width", "1.5");
                    path.setAttribute("class", "connecting-line");
                    path.style.animationDelay = `${index * 0.1}s`;
                    svg.appendChild(path);

                    const dot = document.createElementNS("http://www.w3.org/2000/svg", "circle");
                    dot.setAttribute("cx", endX - 10);
                    dot.setAttribute("cy", endY);
                    dot.setAttribute("r", "2.5");
                    dot.setAttribute("fill", color);
                    dot.setAttribute("class", "node-pulse");
                    svg.appendChild(dot);
                });
            };

            window.addEventListener('resize', drawConnections);
            setTimeout(drawConnections, 950);
'@

$content = [regex]::Replace($content, $jsTarget, $newJs)

[IO.File]::WriteAllText($path, $content)
Write-Host "Pushed logic successfully to user dashboard!"
