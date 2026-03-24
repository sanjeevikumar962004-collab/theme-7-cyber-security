import os
import re

dir_path = r"d:\new themes\cyber security"

for filename in os.listdir(dir_path):
    if filename.endswith('.html'):
        filepath = os.path.join(dir_path, filename)
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Remove the specific <style> tag
            content = re.sub(r'<style>\s*:root\[data-theme="light"\] \.nav-logo-icon\s*\{\s*filter:\s*invert\(1\);\s*\}\s*</style>\n?', '', content)
            
            # Replace stackly.webp with whitelogo.webp
            content = content.replace('src="stackly.webp"', 'src="whitelogo.webp"')
            
            # Remove the drop down shadow filter
            content = re.sub(r'filter:\s*drop-shadow\(0 0 5px #00f2ff\);?\s*', '', content)
            
            # Remove "Stackly" text right after the image
            content = re.sub(r'(<img[^>]*src="whitelogo\.webp"[^>]*>)\s*Stackly\b', r'\1', content)
            
            # Update alt text
            content = content.replace('alt="Stackly Logo"', 'alt="Logo"')

            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"Processed: {filename}")
        except Exception as e:
            print(f"Error processing {filename}: {e}")

print("Done")
