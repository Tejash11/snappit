import Foundation
import Alamofire

enum Dependencies {
    /// Notification posted when auth token expires (401 response)
    static let tokenExpiredNotification = Notification.Name("snappit.tokenExpired")

    static func register() {
        let sl = ServiceLocator.shared

        // Storage
        sl.register { AppStore() }
        sl.register { TokenStore() }

        // Network
        let appStore: AppStore = sl.resolve()
        let tokenStore: TokenStore = sl.resolve()

        let authInterceptor = AuthInterceptor(
            tokenStore: tokenStore,
            appStore: appStore,
            onTokenExpire: {
                NotificationCenter.default.post(name: tokenExpiredNotification, object: nil)
            }
        )
        let connectivityInterceptor = ConnectivityInterceptor()
        let loggingMonitor = LoggingMonitor()

        let interceptor = Interceptor(interceptors: [authInterceptor, connectivityInterceptor])
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30

        let session = Session(
            configuration: configuration,
            interceptor: interceptor,
            eventMonitors: [loggingMonitor]
        )

        sl.register { HTTPClient(session: session, baseURL: Env.hostUrl) }

        // Repositories
        let http: HTTPClient = sl.resolve()
        sl.register { OnboardingRepository(http: http, store: appStore, tokenStore: tokenStore) }
    }
}
