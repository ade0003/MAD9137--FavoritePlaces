# Favorite Places App

An iOS app that lets users save and manage their favorite locations on a map. Users can add new locations by tapping on the map, edit location details, and view their saved places.

## Features

- Interactive map with current location
- Add favorite locations with custom names and descriptions
- Edit and delete saved locations
- Loads preset locations from JSON file
- Persists user-added locations

## Setup

1. Clone the repository
2. Open favPlaces.xcodeproj in Xcode
3. Ensure you have iOS 17.0+ selected as your minimum deployment target
4. Run the app on a real device, using simulator will cause issues with GPS

## Project Structure

```
FavoritePlaces/
├── Models/        # Data models
├── ViewModels/    # Business logic
├── Views/         # UI components
└── App/           # App entry point
```

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

N.B: the keyboard mechanism might be a little slow/buggy on first launch, i've scoured the internet for a solution with no success.
