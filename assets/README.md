# Restaurant App Assets

## Directory Structure

```
assets/
├── images/
│   └── (Add your restaurant food images here)
└── icons/
    └── (Add your custom icons here)
```

## Image Guidelines

### For best results:
- Use high-quality images (minimum 1080x1080px)
- Recommended formats: PNG, JPG
- Keep file sizes optimized (under 500KB per image)

### Suggested Images:
- Restaurant logo
- Food category icons
- Menu item photos
- Restaurant interior/exterior shots

## Current Implementation

The app currently uses:
- **Network Images**: From Unsplash (placeholder images)
- **Material Icons**: Built-in Flutter icons
- **Google Fonts**: Poppins font family

## To Add Local Assets:

1. Create the directories:
   ```bash
   mkdir -p assets/images assets/icons
   ```

2. Add your images to the respective folders

3. Uncomment the assets section in `pubspec.yaml`:
   ```yaml
   flutter:
     uses-material-design: true
     assets:
       - assets/images/
       - assets/icons/
   ```

4. Run: `flutter pub get`

5. Use in code:
   ```dart
   Image.asset('assets/images/your_image.png')
   ```