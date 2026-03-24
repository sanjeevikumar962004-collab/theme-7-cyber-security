$aboutPath = "d:\new themes\cyber security\about.html"
$servicesPath = "d:\new themes\cyber security\services.html"
$blogPath = "d:\new themes\cyber security\blog.html"
$dashboardPath = "d:\new themes\cyber security\admin dasboard.html"

# Fix About Hero text
$aboutContent = Get-Content $aboutPath -Raw -Encoding UTF8
$aboutContent = $aboutContent -replace '\.about-hero-title\s*\{\s*font-size:\s*4rem;', '.about-hero-title { font-size: clamp(2.5rem, 10vw, 4rem);'
$aboutContent = $aboutContent -replace '\.about-hero-title\s*\{\s*font-size:\s*5rem;\s*\}', '.about-hero-title { font-size: clamp(3rem, 8vw, 5rem); }'
$aboutContent = $aboutContent -replace '\.about-hero-title\s*\{\s*font-size:\s*6\.5rem;\s*\}', '.about-hero-title { font-size: clamp(4rem, 8vw, 6.5rem); }'
[IO.File]::WriteAllText($aboutPath, $aboutContent)

# Fix Services Hero & Button
$svcContent = Get-Content $servicesPath -Raw -Encoding UTF8
$svcContent = $svcContent -replace '\.services-hero-title\s*\{\s*font-size:\s*4rem;', '.services-hero-title { font-size: clamp(2.5rem, 10vw, 4rem);'
$svcContent = $svcContent -replace '\.services-hero-title\s*\{\s*font-size:\s*5rem;\s*\}', '.services-hero-title { font-size: clamp(3rem, 8vw, 5rem); }'
$svcContent = $svcContent -replace '\.services-hero-title\s*\{\s*font-size:\s*6\.5rem;\s*\}', '.services-hero-title { font-size: clamp(4rem, 8vw, 6.5rem); }'

# services consultation buttons -> 404
$svcContent = $svcContent -replace '(?s)<button([^>]*)>Request Consultation</button>', '<button$1 onclick="window.location.href=''404.html''">Request Consultation</button>'
[IO.File]::WriteAllText($servicesPath, $svcContent)

# Fix Blog Form & Buttons
$blogContent = Get-Content $blogPath -Raw -Encoding UTF8
# remove <br> from form
$blogContent = $blogContent -replace '<input type="email" placeholder="Enter your work email" class="newsletter-input" required>\s*<br>', '<input type="email" placeholder="Enter your work email" class="newsletter-input" required>'
# fix newsletter-minimal input mobile margin
$blogContent = $blogContent -replace '\.newsletter-minimal \.newsletter-input \{ max-width: 400px; margin: 0 auto 32px auto; font-size: 1\.2rem; text-align: center; \}', '.newsletter-minimal .newsletter-input { width: 100%; max-width: 400px; margin: 0 auto; font-size: 1.2rem; text-align: left; }'
# map Read Article buttons
$blogContent = [regex]::Replace($blogContent, '(?s)<span class="read-more">Read Article', '<button onclick="window.location.href=''404.html''" style="background:none;border:none;padding:0;cursor:pointer;" class="read-more">Read Article')
$blogContent = $blogContent -replace '</path></svg></span>', '</path></svg></button>'
[IO.File]::WriteAllText($blogPath, $blogContent)

# Fix Admin Dashboard Responsiveness
# The table in admin dashboard overflows. Make sure container is scrollable, or add responsive hide.
$dashContent = Get-Content $dashboardPath -Raw -Encoding UTF8
# Wrap the table in div.overflow-x-auto if missing, but it is already there!
# Check Grid of Top Stat Cards: 'grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4' -> Make sure it exists. 
# Looking at the 5 nodes, nodesList is flex-col w-full lg:w-80.
# The user said admin dashboard is not responsive. It might be the grid layout or the canvas sizes.
# Ensure chart-container has max-width: 100% and overflow hidden.
$dashContent = $dashContent -replace '\.chart-container \{', ".chart-container { max-width: 100vw; overflow: hidden;"
# Also ensure the body overflow-x is hidden:
$dashContent = $dashContent -replace 'body \{', "body { overflow-x: hidden;"

[IO.File]::WriteAllText($dashboardPath, $dashContent)

Write-Host "Responsive patches applied."
