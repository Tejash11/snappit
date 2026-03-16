import SwiftUI

@main
struct snappitApp: App {
    @StateObject private var cartViewModel = CartViewModel()
    @StateObject private var appRouter = AppRouter()
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var permissionViewModel = OnboardingPermissionViewModel()

    init() {
        Dependencies.register()
    }

    var body: some Scene {
        WindowGroup {
            rootView
                .environmentObject(cartViewModel)
                .environmentObject(appRouter)
                .onReceive(NotificationCenter.default.publisher(for: Dependencies.tokenExpiredNotification)) { _ in
                    appRouter.handleTokenExpiry()
                }
        }
    }

    @ViewBuilder
    private var rootView: some View {
        switch appRouter.currentRoute {
        case .splash:
            SplashView()
        case .enterNumber:
            EnterNumberView(viewModel: authViewModel)
        case .enterOtp:
            EnterOtpView(viewModel: authViewModel)
        case .locationPermission:
            LocationPermissionView(viewModel: permissionViewModel)
        case .notificationPermission:
            NotificationPermissionView(viewModel: permissionViewModel)
        case .home:
            MainTabView()
        }
    }
}
