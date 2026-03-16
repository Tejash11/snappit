import Foundation

final class ServiceLocator {
    static let shared = ServiceLocator()

    private var factories: [String: () -> Any] = [:]
    private var singletons: [String: Any] = [:]

    private init() {}

    func register<T>(_ factory: @escaping () -> T) {
        let key = String(describing: T.self)
        factories[key] = factory
    }

    func resolve<T>() -> T {
        let key = String(describing: T.self)
        if let singleton = singletons[key] as? T {
            return singleton
        }
        guard let factory = factories[key] else {
            fatalError("Service not registered: \(key)")
        }
        let instance = factory() as! T
        singletons[key] = instance
        return instance
    }

    func remove<T>(_ type: T.Type) {
        let key = String(describing: T.self)
        singletons.removeValue(forKey: key)
    }

    func clear() {
        singletons.removeAll()
    }
}

/// Global helper to resolve a singleton from ServiceLocator
func singleton<T>() -> T {
    ServiceLocator.shared.resolve()
}
