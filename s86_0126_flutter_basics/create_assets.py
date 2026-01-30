from PIL import Image, ImageDraw

# Create logo.png (200x200 blue square with Flutter logo design)
img = Image.new('RGB', (200, 200), color=(33, 150, 243))
draw = ImageDraw.Draw(img)
draw.ellipse([50, 50, 150, 150], fill=(255, 255, 255), outline=(0, 0, 0), width=2)
draw.text((70, 85), "SPORTS", fill=(33, 150, 243))
img.save('assets/images/logo.png')
print("✓ Created logo.png")

# Create banner.jpg (400x200 gradient banner)
img = Image.new('RGB', (400, 200), color=(76, 175, 80))
draw = ImageDraw.Draw(img)
for i in range(200):
    color = (76 + i//3, 175 + i//5, 80 + i//3)
    draw.line([(0, i), (400, i)], fill=color)
draw.text((150, 80), "Live Tournaments", fill=(255, 255, 255))
img.save('assets/images/banner.jpg')
print("✓ Created banner.jpg")

# Create background.png (300x300 with pattern)
img = Image.new('RGB', (300, 300), color=(240, 240, 240))
draw = ImageDraw.Draw(img)
for i in range(0, 300, 30):
    draw.line([(i, 0), (i, 300)], fill=(200, 200, 200), width=1)
    draw.line([(0, i), (300, i)], fill=(200, 200, 200), width=1)
draw.rectangle([50, 50, 250, 250], fill=(100, 150, 200), outline=(50, 100, 150), width=3)
draw.text((110, 130), "Assets", fill=(255, 255, 255))
img.save('assets/images/background.png')
print("✓ Created background.png")

# Create star.png (icon)
img = Image.new('RGBA', (64, 64), color=(0, 0, 0, 0))
draw = ImageDraw.Draw(img)
draw.polygon([(32, 10), (39, 28), (58, 28), (43, 40), (50, 58), (32, 46), (14, 58), (21, 40), (6, 28), (25, 28)], fill=(255, 215, 0))
img.save('assets/icons/star.png')
print("✓ Created star.png")

# Create profile.png (icon)
img = Image.new('RGBA', (64, 64), color=(0, 0, 0, 0))
draw = ImageDraw.Draw(img)
draw.ellipse([16, 8, 48, 32], fill=(76, 175, 80))
draw.ellipse([12, 28, 52, 56], fill=(76, 175, 80))
img.save('assets/icons/profile.png')
print("✓ Created profile.png")

print("\nAll assets created successfully!")
