![Captura de pantalla 2024-07-13 a las 12 30 06](https://github.com/user-attachments/assets/3f56c45f-8d1c-4c97-bc22-e25cd0ff5cf4)


# MyWorld 🌐

Welcome to **MyWorld**! This app helps users explore nearby locations, find destinations, and manage favorites and recent visits.

## Features

- **Location Search**: Users can search for nearby locations such as gas stations, restaurants, banks, and more.
- **Favorites**: Users can mark locations as favorites, and the app will store them for easy access.
- **Recents**: Recently visited locations are saved for quick access later.
- **Map Integration**: The app integrates with Apple Maps to show routes, previews, and location details.
- **Web View**: Open the website related to a location, if available.
- **Dynamic Island Support**: For supported devices, dynamic island notifications are provided during navigation.

## Technologies

- **SwiftUI**: Used to build the app's UI components.
- **MapKit**: Apple’s mapping framework for displaying maps, annotations, and routes.
- **SwiftData**: Manages local data, such as favorite and recent locations.
- **Combine**: Reactive framework used to handle the app's state changes.
- **WebKit**: Enables web content display within the app.

## Screens and Components

### 1. `LocationView`

This screen displays the selected location’s details, offering buttons to:

- Open in Apple Maps
- View location’s website
- Call the location’s phone number
- Add/Remove from favorites
- Start navigation

Additionally, it displays the **Look Around** preview when available or a placeholder if not.

### 2. `DestinationsSheet`

This sheet allows users to:

- Search for locations
- Browse favorite locations
- Find nearby categories (e.g., Restaurants, Gas Stations)
- View recent locations
- Load more nearby categories

### 3. `ContentView`

Main view of the app that integrates the map and allows users to:

- View their current location
- Search for places and see results on the map
- Select a place for detailed information

The app uses a `ZStack` to combine map display, modals, and additional features.

### 4. `MapViewModel`

Handles the interaction with MapKit:

- **Search**: Allows users to search for locations via `MKLocalSearch`.
- **Routes**: Fetches and displays walking routes between the user's current location and the selected destination.
- **Location Management**: Manages user location services, including requesting location permissions.
- **Look Around**: Fetches Apple Maps' **Look Around** scenes for locations, if available.

### 5. `WebViewModel`

Manages the web view component, allowing users to load location websites directly in the app. Handles loading states and errors (e.g., displaying a "404 Page Not Found" message).

### 6. `SwiftDataViewModel`

This view model handles the persistence of favorite and recent locations using **SwiftData**.

- **Favorites**: Users can add and remove locations from their favorites list.
- **Recents**: The app automatically saves recently viewed locations.
- Data is fetched and stored using `ModelContainer` and `FetchDescriptor` from SwiftData.

## How to Use

1. **Search for a location**: Enter a location in the search bar on the `DestinationsSheet` and tap on a result to view its details.
2. **Mark a favorite**: While viewing a location, tap the heart icon to save it as a favorite.
3. **View favorites and recents**: Use the horizontal scrollable list in the `DestinationsSheet` to quickly access favorite or recent locations.
4. **Navigate to a destination**: Once a location is selected, start navigation by tapping the arrow icon.
5. **Open a website**: Tap the globe icon to view the location’s website, if available.

## Dynamic Island Integration

For devices that support **Dynamic Island**, the app will send a notification when navigation starts, providing an ongoing route update in the dynamic island area.

## Installation

1. Clone the repository.
    ```bash
    git clone https://github.com/your-repo/MyWorld.git
    ```
2. Open the project in Xcode.
3. Build and run the app on your device or simulator.

## Requirements

- **iOS 16+**
- **Xcode 14+**

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
