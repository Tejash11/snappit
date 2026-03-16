import SwiftUI
import Combine
import CoreLocation
import UserNotifications

@MainActor
class OnboardingPermissionViewModel: ObservableObject {
    @Published var locationStatus: CLAuthorizationStatus = .notDetermined

    private let locationDelegate = LocationDelegate()
    private let locationManager = CLLocationManager()
    private var cancellable: AnyCancellable?

    init() {
        locationManager.delegate = locationDelegate
        locationStatus = locationManager.authorizationStatus

        cancellable = locationDelegate.$authorizationStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                self?.locationStatus = status
            }
    }

    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func requestNotificationPermission() async -> Bool {
        do {
            return try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound])
        } catch {
            print("[Snappit] Notification permission error: \(error)")
            return false
        }
    }

    func markOnboardingComplete() {
        let appStore: AppStore = singleton()
        appStore.onboardingPermissionsCompleted = true
    }

    static func shouldShowOnboarding() -> Bool {
        let appStore: AppStore = singleton()
        return !appStore.onboardingPermissionsCompleted
    }
}

// CLLocationManagerDelegate must be NSObject — separate helper to avoid @MainActor issues
private class LocationDelegate: NSObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}
