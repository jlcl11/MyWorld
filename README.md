<p align="center">
  <img width="1500" alt="MyWorld" src="https://github.com/user-attachments/assets/3f56c45f-8d1c-4c97-bc22-e25cd0ff5cf4" />
</p>

<h1 align="center">
  <br>
  MyWorld 🌐
  <br>
</h1>

<h3 align="center">Discover, save and navigate to places, with Look Around previews and walking routes.</h3>

<p align="center">
  <strong>MapKit</strong> &nbsp;·&nbsp; <strong>Look Around</strong> &nbsp;·&nbsp; <strong>SwiftData</strong> &nbsp;·&nbsp; <strong>Combine</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/iOS_17.4%2B-000000?style=for-the-badge&logo=apple&logoColor=white" alt="iOS 17.4+">
  <img src="https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=swift&logoColor=white" alt="Swift">
  <img src="https://img.shields.io/badge/SwiftUI-007AFF?style=for-the-badge&logo=swift&logoColor=white" alt="SwiftUI">
  <img src="https://img.shields.io/badge/MapKit-30D158?style=for-the-badge&logo=apple&logoColor=white" alt="MapKit">
  <img src="https://img.shields.io/badge/SwiftData-FF9500?style=for-the-badge&logo=swift&logoColor=white" alt="SwiftData">
</p>

---

## What is MyWorld

MyWorld is a location-discovery app that puts MapKit's modern surfaces — Look Around previews and integrated walking routes — into one focused product. Search nearby places, save favourites and navigate, with the active route shown in a Dynamic Island–style banner inside the app.

Built with SwiftUI + Combine for reactive state, SwiftData for local persistence and WebKit for in-app site previews.

---

## Features

| | |
|---|---|
| **Search** | Find nearby places by category (restaurants, gas stations, banks, ATMs, hotels, etc.) using `MKLocalSearch`. |
| **Look Around** | Inline `LookAroundPreview` for any location that supports it, with graceful fallback when unavailable. |
| **Routes** | Walking routes from current location to selected destination via `MKDirections`, drawn on the map. |
| **Favourites & Recents** | One-tap save to favourites. Recent visits are tracked automatically. Both persisted with SwiftData. |
| **Web view** | Open the location's website in an embedded WebKit view with loading + error states (including a 404 placeholder). |
| **Route banner** | A custom SwiftUI `DynamicIslandView`, drawn inside the app, shows the active route in a pill-shaped banner at the top of the screen. It is not a Live Activity, so it disappears when you leave the app. |

---

## Screens

| Screen | Role |
|---|---|
| **ContentView** | Main map surface, sheets and current location |
| **DestinationsSheet** | Search bar, categories carousel, favourites and recents |
| **LocationView** | Selected place detail: Open in Maps, Website, Call, Favourite, Navigate |

---

## Architecture

```
MyWorld/
  ContentView.swift             Map + overlays + Dynamic Island view
  MyWorldApp.swift              App entry
  Views/
    DestinationsSheet.swift     Search + categories + recents
    LocationView.swift          Place detail + Look Around + actions
    Components/                 Reusable views (incl. DynamicIslandView, Web/)
  ViewModels/
    MapViewModel.swift          MKLocalSearch + MKDirections + Look Around
    WebViewModel.swift          WKWebView loading and error states
    SwiftDataViewModel.swift    Favourites + Recents persistence
  Models/
    FavoriteLocation.swift      SwiftData entity (favourites)
    RecentLocation.swift        SwiftData entity (recents)
```

---

## How Search Works

```
   User types query
         │
         ▼
   ┌──────────────┐         ┌──────────────────┐
   │ MKLocalSearch│────────►│ Map annotations  │
   └──────────────┘         └──────────────────┘
         │                          │
         ▼                          ▼
   ┌──────────────┐         ┌──────────────────┐
   │ Look Around  │         │ Walking route    │
   │ preview      │         │ via MKDirections │
   └──────────────┘         └──────────────────┘
                                    │
                                    ▼
                            ┌──────────────────┐
                            │ DynamicIslandView│
                            │ overlay (in-app) │
                            └──────────────────┘
```

---

## Quick Start

**Requirements:** Xcode 15.3+ · iOS 17.4+

```bash
git clone https://github.com/jlcl11/MyWorld.git
cd MyWorld
open MyWorld.xcodeproj
```

Add an `NSLocationWhenInUseUsageDescription` entry to Info.plist (already included), build and run.

---

## Tech Stack

| Technology | Role |
|---|---|
| **SwiftUI** | Declarative UI layer |
| **MapKit** | Map, annotations, walking routes, Look Around |
| **SwiftData** | Local persistence of favourites and recents |
| **Combine** | `@Published` view-model state for map / web / persistence |
| **WebKit** | `WKWebView` in-app website previews with loading + error states |

---

<p align="center">
  Built by <a href="https://github.com/jlcl11">Jose Luis Corral Lopez</a> · Portfolio sample of MapKit's modern surfaces (2024)
</p>
