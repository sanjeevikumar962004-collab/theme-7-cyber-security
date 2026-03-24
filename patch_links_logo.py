import os
import re

dir_path = r"d:\new themes\cyber security"

style_to_add = '<style>:root[data-theme="light"] img[src="whitelogo.webp"] { filter: brightness(0); }</style>\n</head>'

for filename in os.listdir(dir_path):
    if filename.endswith('.html'):
        filepath = os.path.join(dir_path, filename)
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()

            # Add the style right before </head> if it's not already there
            if ':root[data-theme="light"] img[src="whitelogo.webp"]' not in content:
                content = content.replace('</head>', style_to_add)

            # Fix all Contact href="#" links
            content = re.sub(r'<a href="#"([^>]*)>Contact</a>', r'<a href="contact.html"\1>Contact</a>', content)
            
            # Since previously they had login link as 404, the prompt says "update the navigation header to navigate to respective pages"
            # Let's ensure Login navigates to login.html
            content = re.sub(r'<a href="404\.html"([^>]*)>Login</a>', r'<a href="login.html"\1>Login</a>', content)
            content = re.sub(r'onclick="window\.location\.href=\'404\.html\'">Login</button>', r'onclick="window.location.href=\'login.html\'">Login</button>', content)

            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"Patched: {filename}")
        except Exception as e:
            print(f"Error patching {filename}: {e}")

print("Done patching.")
