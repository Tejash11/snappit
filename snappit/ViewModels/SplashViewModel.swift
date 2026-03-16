import Foundation
import Combine

@MainActor
class SplashViewModel: ObservableObject {

    func determineRoute(appRouter: AppRouter) async {
        // Brief splash delay for branding
        try? await Task.sleep(for: .seconds(1.5))

        let tokenStore: TokenStore = singleton()
        let appStore: AppStore = singleton()

        // Check both token (Keychain) AND UserDefaults data.
        // Keychain persists across app deletions on iOS, so we also
        // verify UserDefaults has user data (which gets cleared on delete).
        if let token = tokenStore.token, !token.isEmpty,
           appStore.getUserCacheData() != nil {
            if OnboardingPermissionViewModel.shouldShowOnboarding() {
                appRouter.navigateTo(.locationPermission)
            } else {
                appRouter.navigateTo(.home)
            }
        } else {
            // Clear stale keychain token if UserDefaults was wiped
            tokenStore.clear()
            appRouter.navigateTo(.enterNumber)
        }
    }
}
