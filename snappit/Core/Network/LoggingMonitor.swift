import Foundation
import Alamofire

final class LoggingMonitor: EventMonitor {
    let queue = DispatchQueue(label: "com.snappit.logging")

    func requestDidFinish(_ request: Request) {
        #if DEBUG
        guard let urlRequest = request.request else { return }
        let curl = buildCurlCommand(urlRequest)
        print("\n\(curl)\n")
        #endif
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        #if DEBUG
        let method = request.request?.httpMethod ?? "?"
        let url = request.request?.url?.absoluteString ?? "?"
        let statusCode = response.response?.statusCode ?? 0
        print("\(method) \(url) → HTTP \(statusCode)")

        if let data = response.data, let body = String(data: data, encoding: .utf8) {
            if body.count <= 2000 {
                print(body)
            } else {
                print(body.prefix(2000) + "... (truncated)")
            }
        }
        #endif
    }

    private func buildCurlCommand(_ request: URLRequest) -> String {
        var parts = ["curl -X \(request.httpMethod ?? "GET")"]

        request.allHTTPHeaderFields?.forEach { key, value in
            let escaped = value.replacingOccurrences(of: "\"", with: "\\\"")
            parts.append("-H \"\(key): \(escaped)\"")
        }

        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            let escaped = bodyString.replacingOccurrences(of: "'", with: "'\\''")
            parts.append("-d '\(escaped)'")
        }

        parts.append("\"\(request.url?.absoluteString ?? "")\"")
        parts.append("-L")

        return parts.joined(separator: " \\\n  ")
    }
}
