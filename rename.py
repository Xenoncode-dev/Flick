import os

directory = '/home/prakhar_kumar/Code/Flick/FlickCode'

replacements = [
    ('package:playtorrio', 'package:flick'),
    ('com.example.playtorrio', 'com.example.flick'),
    ('playtorrio', 'flick'),
    ('Playtorrio', 'Flick'),
    ('PlayTorrio', 'Flick'),
    ('playTorrio', 'flick')
]

# Specifically exclude some files/dirs like .git, build, etc.
exclude_dirs = {'.git', '.dart_tool', 'build', 'android/app/build', 'ios/Pods', 'macos/Pods', 'linux/build', 'windows/build'}
exclude_files = {'rename.py'}

def process_file(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception:
        return False
        
    original_content = content
    for old, new in replacements:
        content = content.replace(old, new)
        
    if content != original_content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        return True
    return False

modified_count = 0
for root, dirs, files in os.walk(directory):
    dirs[:] = [d for d in dirs if d not in exclude_dirs]
    for file in files:
        if file in exclude_files:
            continue
        filepath = os.path.join(root, file)
        if process_file(filepath):
            modified_count += 1
            print(f"Modified: {filepath}")

print(f"Total files modified: {modified_count}")
