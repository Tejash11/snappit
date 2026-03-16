import SwiftUI
import Combine

enum AppRoute {
    case splash
    case enterNumber
    case enterOtp
    case locationPermission
    case notificationPermission
    case home
}

@MainActor
class AppRouter: ObservableObject {
    @Published var currentRoute: AppRoute = .splash

    func navigateTo(_ route: AppRoute) {
        withAnimation {
            currentRoute = route
        }
    }

    func handleTokenExpiry() {
        let tokenStore: TokenStore = singleton()
        let appStore: AppStore = singleton()
        tokenStore.clear()
        appStore.clear()
        navigateTo(.enterNumber)
    }
}
