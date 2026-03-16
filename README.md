# Snappit

A quick commerce grocery delivery app built with SwiftUI, inspired by platforms like Blinkit and Zepto.

## Tech Stack

- **Language:** Swift 6.2
- **UI Framework:** SwiftUI
- **Architecture:** MVVM
- **Minimum Target:** iOS 26
- **IDE:** Xcode 26

## Dependencies

- [Alamofire 5.11.1](https://github.com/Alamofire/Alamofire) — Networking
- [KeychainAccess 4.2.2](https://github.com/kishikawakatsumi/KeychainAccess) — Secure token storage

## Project Structure

```
snappit/
├── App/                  # App entry point & dependency injection
├── Core/
│   ├── Network/          # HTTPClient, interceptors, API paths
│   ├── Storage/          # KeyValueStore, TokenStore, AppStore
│   ├── ServiceLocator.swift
│   └── Environment.swift # Build config (dev/staging/prod)
├── Models/               # Data models (Auth, Product, Cart, etc.)
├── Repositories/         # Data layer (API calls)
├── ViewModels/           # Business logic
├── Views/
│   ├── Splash/           # Splash screen
│   ├── Onboarding/       # Phone number & OTP verification
│   ├── Home/             # Home screen with widgets
│   ├── Categories/       # Category browsing
│   ├── Cart/             # Shopping cart
│   ├── Orders/           # Order history
│   └── Profile/          # User profile
├── Components/           # Reusable UI components
├── Navigation/           # App router & navigation
└── Services/             # Local data services
```

## Features

- OTP-based phone authentication
- Guest login support
- Home screen with product widgets
- Category browsing
- Shopping cart management
- Tab-based navigation (Home, Categories, Cart, Orders, Profile)

## Setup

1. Clone the repository
2. Open `snappit.xcodeproj` in Xcode 26
3. Dependencies are managed via Swift Package Manager and will resolve automatically
4. Build and run on the iPhone 17 Pro simulator
