import Foundation
import Network
import Alamofire

final class ConnectivityMonitor {
    static let shared = ConnectivityMonitor()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "com.snappit.connectivity")
    private(set) var isConnected = true

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}

final class ConnectivityInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        if ConnectivityMonitor.shared.isConnected {
            completion(.success(urlRequest))
        } else {
            completion(.failure(APIError.noInternet))
        }
    }
}
