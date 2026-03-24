import os
import re

dir_path = "d:/new themes/cyber security"

pages = [
    "about.html", "services.html", "blog.html", "contact.html", 
    "404.html", "forgot.html", "login.html", "signup.html"
]

header_template = """        <div class="nav-links">
            <a href="{home}" class="magnetic-elem"{home_style}>Home</a>
            <a href="{about}" class="magnetic-elem"{about_style}>About</a>
            <a href="{services}" class="magnetic-elem"{services_style}>Services</a>
            <a href="{blog}" class="magnetic-elem"{blog_style}>Blog</a>
            <a href="{contact}" class="magnetic-elem"{contact_style}>Contact</a>
        </div>"""

mobile_template = """        <nav class="mobile-nav">
            <a href="{home}"{home_style}>Home</a>
            <a href="{about}"{about_style}>About</a>
            <a href="{services}"{services_style}>Services</a>
            <a href="{blog}"{blog_style}>Blog</a>
            <a href="{contact}"{contact_style}>Contact</a>
            <a href="{login}" style="color: var(--text-white); font-weight: 500; font-size: 1.2rem; margin-top: 40px; border-bottom: 1px solid var(--text-white); padding-bottom: 8px;">Login</a>
        </nav>"""

footer_template = """                    <ul class="footer-links">
                        <li><a href="{home}">Home</a></li>
                        <li><a href="{about}">About</a></li>
                        <li><a href="{services}">Services</a></li>
                        <li><a href="{blog}">Blog</a></li>
                        <li><a href="{contact}">Contact</a></li>
                    </ul>"""

# Regex patterns to find blocks (using dotall)
header_pattern = re.compile(r'<div class="nav-links">\s*(?:<a[^>]*>.+?</a>\s*){5}</div>', re.DOTALL | re.IGNORECASE)
mobile_pattern = re.compile(r'<nav class="mobile-nav">\s*(?:<a[^>]*>.+?</a>\s*){6}</nav>', re.DOTALL | re.IGNORECASE)
footer_pattern = re.compile(r'<ul class="footer-links">\s*(?:<li><a[^>]*>.+?</a></li>\s*){5}</ul>', re.DOTALL | re.IGNORECASE)

# Some files might not have 6 links in the mobile nav, let's just do a greedy replacement but be careful
# Actually, the best way is to replace the chunk accurately
mobile_pattern_safe = re.compile(r'<nav class="mobile-nav">(?:(?!</nav>).)*?</nav>', re.DOTALL | re.IGNORECASE)

def patch_file(filename):
    filepath = os.path.join(dir_path, filename)
    if not os.path.exists(filepath):
        print(f"File not found: {filename}")
        return

    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Determine active page
    h_style = ""
    a_style = ""
    s_style = ""
    b_style = ""
    c_style = ""
    
    active_style = ' style="color: var(--text-white);"'

    if filename == "index.html": h_style = active_style
    elif filename == "about.html": a_style = active_style
    elif filename == "services.html": s_style = active_style
    elif filename == "blog.html": b_style = active_style
    elif filename == "contact.html": c_style = active_style

    new_header = header_template.format(
        home="index.html", home_style=h_style,
        about="about.html", about_style=a_style,
        services="services.html", services_style=s_style,
        blog="blog.html", blog_style=b_style,
        contact="contact.html", contact_style=c_style
    )

    new_mobile = mobile_template.format(
        home="index.html", home_style=h_style.replace('style="', 'style="'),  # same active link logic can apply if desired
        about="about.html", about_style=a_style,
        services="services.html", services_style=s_style,
        blog="blog.html", blog_style=b_style,
        contact="contact.html", contact_style=c_style,
        login="login.html"
    )

    new_footer = footer_template.format(
        home="index.html", about="about.html", services="services.html", blog="blog.html", contact="contact.html"
    )

    new_content = header_pattern.sub(new_header, content)
    new_content = mobile_pattern_safe.sub(new_mobile, new_content)
    new_content = footer_pattern.sub(new_footer, new_content)

    # Some pages like userdashboard or admin dashboard might need slightly different patches if they use different navs, but typically they don't use this header
    if content != new_content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Patched {filename}")
    else:
        print(f"No changes made to {filename} (might already be patched or no matching block found)")

for page in pages:
    patch_file(page)

print("Nav patching complete.")
