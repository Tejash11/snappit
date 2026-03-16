import Foundation

enum APIError: Error, LocalizedError {
    case noInternet
    case timeout
    case unauthorized
    case serverError(String)
    case badResponse(Int, String?)
    case decodingError(String)
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No internet connection. Please check your network."
        case .timeout:
            return "Request timed out. Please try again."
        case .unauthorized:
            return "Session expired. Please login again."
        case .serverError(let message):
            return message
        case .badResponse(let code, let message):
            return message ?? "Something went wrong (Error \(code))"
        case .decodingError(let message):
            return "Failed to process response: \(message)"
        case .unknown(let message):
            return message
        }
    }

    var userFriendlyMessage: String {
        errorDescription ?? "Something went wrong. Please try again."
    }
}
