import Foundation
import KeychainAccess

final class TokenStore {
    private let keychain: Keychain
    private static let tokenKey = "_token"

    init(service: String = "com.tejashseth.snappit") {
        keychain = Keychain(service: service)
    }

    var token: String? {
        get {
            try? keychain.get(Self.tokenKey)
        }
        set {
            if let newValue {
                try? keychain.set(newValue, key: Self.tokenKey)
            } else {
                try? keychain.remove(Self.tokenKey)
            }
        }
    }

    var authHeader: String {
        guard let token, !token.isEmpty else { return "" }
        return "token \(token)"
    }

    func clear() {
        try? keychain.removeAll()
    }
}
