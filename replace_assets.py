import os
import re
import glob
import random

def replace_in_files(directory):
    # Get all local images
    image_dir = os.path.join(directory, 'images')
    local_images = []
    if os.path.exists(image_dir):
        local_images = [f for f in os.listdir(image_dir) if f.endswith(('.webp', '.jpg', '.png'))]
    
    html_files = glob.glob(os.path.join(directory, '*.html'))
    
    # Regex patterns
    # Logo replacement
    svg_pattern = re.compile(r'<svg class="nav-logo-icon".*?<\/svg>', re.DOTALL)
    new_logo = '<img src="stackly.webp" class="nav-logo-icon" alt="Stackly Logo" style="width: 24px; height: 24px; object-fit: contain;">'
    
    # Unsplash URL replacement
    unsplash_pattern = re.compile(r'https://images\.unsplash\.com/[^"\'\)\s]+')
    
    for filepath in html_files:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
            
        original = content
            
        # 1. Replace logo
        content = svg_pattern.sub(new_logo, content)
        
        # 2. Replace Unsplash with local images
        def repl_img(match):
            if not local_images:
                return match.group(0)
            img = random.choice(local_images)
            return f"images/{img}"
        
        content = unsplash_pattern.sub(repl_img, content)
        
        # 3. Replace Sign In with Login
        content = content.replace('>Sign In<', '>Login<')
        
        if content != original:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"Updated {os.path.basename(filepath)}")

if __name__ == "__main__":
    replace_in_files(r'd:\new themes\cyber security')
