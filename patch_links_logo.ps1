$dir = "d:\new themes\cyber security"
$styleToAdd = "<style>:root[data-theme=`"light`"] img[src=`"whitelogo.webp`"] { filter: brightness(0); }</style>`n</head>"

Get-ChildItem -Path $dir -Filter *.html | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding UTF8
    
    if (-not ($content -match 'filter: brightness\(0\)')) {
        $content = $content -replace '</head>', $styleToAdd
    }
    
    # Fix all Contact href="#" links
    $content = $content -replace '<a href="#"([^>]*)>Contact</a>', '<a href="contact.html"$1>Contact</a>'
    
    # Ensure Login navigates to login.html
    $content = $content -replace '<a href="404\.html"([^>]*)>Login</a>', '<a href="login.html"$1>Login</a>'
    $content = $content -replace 'onclick="window\.location\.href=''404\.html''">Login</button>', 'onclick="window.location.href=''login.html''">Login</button>'
    
    # Ensure logo href navigates to index
    $content = $content -replace '<a href="404\.html" class="nav-logo magnetic-elem">', '<a href="index.html" class="nav-logo magnetic-elem">'

    [IO.File]::WriteAllText($_.FullName, $content)
    Write-Host "Patched $($_.Name)"
}
Write-Host "Done patching."
