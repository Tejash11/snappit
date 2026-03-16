import Foundation

final class AppStore: KeyValueStore {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func getInt(_ key: String) -> Int {
        defaults.integer(forKey: key)
    }

    func getDouble(_ key: String) -> Double {
        defaults.double(forKey: key)
    }

    func getBool(_ key: String) -> Bool {
        defaults.bool(forKey: key)
    }

    func getString(_ key: String) -> String {
        defaults.string(forKey: key) ?? ""
    }

    func getStringList(_ key: String) -> [String] {
        defaults.stringArray(forKey: key) ?? []
    }

    func getJsonObject(_ key: String) -> [String: Any] {
        guard let data = defaults.string(forKey: key)?.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return [:]
        }
        return json
    }

    func getJsonArray(_ key: String) -> [[String: Any]] {
        guard let data = defaults.string(forKey: key)?.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return []
        }
        return json
    }

    func putInt(_ key: String, _ value: Int) {
        defaults.set(value, forKey: key)
    }

    func putDouble(_ key: String, _ value: Double) {
        defaults.set(value, forKey: key)
    }

    func putBool(_ key: String, _ value: Bool) {
        defaults.set(value, forKey: key)
    }

    func putString(_ key: String, _ value: String) {
        defaults.set(value, forKey: key)
    }

    func putStringList(_ key: String, _ value: [String]) {
        defaults.set(value, forKey: key)
    }

    func putJsonObject(_ key: String, _ json: [String: Any]) {
        if let data = try? JSONSerialization.data(withJSONObject: json),
           let string = String(data: data, encoding: .utf8) {
            defaults.set(string, forKey: key)
        }
    }

    func putJsonArray(_ key: String, _ array: [[String: Any]]) {
        if let data = try? JSONSerialization.data(withJSONObject: array),
           let string = String(data: data, encoding: .utf8) {
            defaults.set(string, forKey: key)
        }
    }

    func remove(_ key: String) {
        defaults.removeObject(forKey: key)
    }

    func clear() {
        guard let bundleId = Bundle.main.bundleIdentifier else { return }
        defaults.removePersistentDomain(forName: bundleId)
    }

    // MARK: - Convenience accessors matching Flutter's stored keys

    var userId: Int {
        get { getInt("_userId") }
        set { putInt("_userId", newValue) }
    }

    var onboardingPageVisited: Bool {
        get { getBool("_onboardingPageVisited") }
        set { putBool("_onboardingPageVisited", newValue) }
    }

    var permissionPageVisited: Bool {
        get { getBool("_permissionPageVisited") }
        set { putBool("_permissionPageVisited", newValue) }
    }

    var onboardingPermissionsCompleted: Bool {
        get { getBool("onboardingPermissionsCompleted") }
        set { putBool("onboardingPermissionsCompleted", newValue) }
    }

    var selectedLanguage: String {
        get { getString("selected_language") }
        set { putString("selected_language", newValue) }
    }

    func setUserCacheData(_ data: UserCacheData) {
        if let encoded = try? JSONEncoder().encode(data),
           let string = String(data: encoded, encoding: .utf8) {
            defaults.set(string, forKey: "user_cache_data")
        }
    }

    func getUserCacheData() -> UserCacheData? {
        guard let string = defaults.string(forKey: "user_cache_data"),
              let data = string.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(UserCacheData.self, from: data)
    }
}
