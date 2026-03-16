import Foundation
import Alamofire

final class AuthInterceptor: RequestInterceptor {
    private let tokenStore: TokenStore
    private let appStore: AppStore
    private let onTokenExpire: () -> Void

    init(tokenStore: TokenStore, appStore: AppStore, onTokenExpire: @escaping () -> Void) {
        self.tokenStore = tokenStore
        self.appStore = appStore
        self.onTokenExpire = onTokenExpire
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        request.setValue(tokenStore.authHeader, forHTTPHeaderField: "AUTHORIZATION")
        request.setValue("ios", forHTTPHeaderField: "PLATFORM")
        request.setValue(appVersion, forHTTPHeaderField: "VERSION")
        request.setValue(userAgent, forHTTPHeaderField: "User-Agent")
        request.setValue(language, forHTTPHeaderField: "x-language")
        completion(.success(request))
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401,
              !(request.request?.url?.path.contains(APIPaths.logout) ?? false) else {
            completion(.doNotRetry)
            return
        }
        onTokenExpire()
        completion(.doNotRetry)
    }

    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    private var userAgent: String {
        "snappit-ios/\(appVersion)"
    }

    private var language: String {
        let lang = appStore.selectedLanguage
        return lang.isEmpty ? "en" : lang
    }
}
