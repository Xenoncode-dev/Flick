import os
import shutil
import glob

icon_path = 'assets/icon.png'

if not os.path.exists(icon_path):
    print(f"Error: {icon_path} not found.")
    exit(1)

# Replace Android icons
android_res = 'android/app/src/main/res/'
for mipmap in glob.glob(os.path.join(android_res, 'mipmap-*')):
    for icon_name in ['ic_launcher.png', 'ic_launcher_round.png']:
        target = os.path.join(mipmap, icon_name)
        if os.path.exists(target):
            shutil.copy(icon_path, target)
            print(f"Replaced {target}")

# Replace iOS icons
ios_res = 'ios/Runner/Assets.xcassets/AppIcon.appiconset/'
for target in glob.glob(os.path.join(ios_res, '*.png')):
    shutil.copy(icon_path, target)
    print(f"Replaced {target}")

# Replace macOS icons
macos_res = 'macos/Runner/Assets.xcassets/AppIcon.appiconset/'
for target in glob.glob(os.path.join(macos_res, '*.png')):
    shutil.copy(icon_path, target)
    print(f"Replaced {target}")

print("Done replacing icons.")
