import Foundation

protocol KeyValueStore {
    func getInt(_ key: String) -> Int
    func getDouble(_ key: String) -> Double
    func getBool(_ key: String) -> Bool
    func getString(_ key: String) -> String
    func getStringList(_ key: String) -> [String]
    func getJsonObject(_ key: String) -> [String: Any]
    func getJsonArray(_ key: String) -> [[String: Any]]

    func putInt(_ key: String, _ value: Int)
    func putDouble(_ key: String, _ value: Double)
    func putBool(_ key: String, _ value: Bool)
    func putString(_ key: String, _ value: String)
    func putStringList(_ key: String, _ value: [String])
    func putJsonObject(_ key: String, _ json: [String: Any])
    func putJsonArray(_ key: String, _ array: [[String: Any]])

    func remove(_ key: String)
    func clear()
}
