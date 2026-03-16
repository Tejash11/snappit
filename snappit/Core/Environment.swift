import Foundation

enum AppEnvironment: String {
    case dev, staging, prod
}

struct Env {
    static var current: AppEnvironment = .dev

    static var hostUrl: String {
        switch current {
        case .dev:
            return "https://samaan.apnamart.in"
        case .staging:
            return "https://staging.apnamart.in"
        case .prod:
            return "https://samaan.apnamart.in"
        }
    }

    static var apiKey: String {
        switch current {
        case .dev:
            return ""
        case .staging:
            return ""
        case .prod:
            return ""
        }
    }

    static var isDev: Bool { current == .dev }
    static var isStaging: Bool { current == .staging }
    static var isProd: Bool { current == .prod }
}
