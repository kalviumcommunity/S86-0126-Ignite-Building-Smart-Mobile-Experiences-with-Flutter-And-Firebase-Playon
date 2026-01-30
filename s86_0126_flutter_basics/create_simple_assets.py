import base64
import os

# Simple 1x1 blue PNG
logo_base64 = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mM8//8/AwAI/AL+O965KgAAAABJRU5ErkJggg=="
banner_base64 = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg=="
background_base64 = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg=="

# Create placeholder PNGs
with open('assets/images/logo.png', 'wb') as f:
    f.write(base64.b64decode(logo_base64))
    
with open('assets/images/banner.jpg', 'wb') as f:
    f.write(base64.b64decode(banner_base64))
    
with open('assets/images/background.png', 'wb') as f:
    f.write(base64.b64decode(background_base64))

with open('assets/icons/star.png', 'wb') as f:
    f.write(base64.b64decode(logo_base64))
    
with open('assets/icons/profile.png', 'wb') as f:
    f.write(base64.b64decode(banner_base64))

print("Assets created successfully!")
