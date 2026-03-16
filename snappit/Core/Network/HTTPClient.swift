import Foundation
import Alamofire

final class HTTPClient {
    private let session: Session
    private let baseURL: String

    init(session: Session, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }

    func get<T: Decodable>(
        path: String,
        parameters: [String: Any]? = nil,
        type: T.Type = T.self
    ) async throws -> T {
        let url = baseURL + path
        return try await session.request(
            url,
            method: .get,
            parameters: parameters
        )
        .validate()
        .serializingDecodable(T.self)
        .value
    }

    func post<T: Decodable>(
        path: String,
        body: [String: Any]? = nil,
        type: T.Type = T.self
    ) async throws -> T {
        let url = baseURL + path
        return try await session.request(
            url,
            method: .post,
            parameters: body,
            encoding: JSONEncoding.default
        )
        .validate()
        .serializingDecodable(T.self)
        .value
    }

    func put<T: Decodable>(
        path: String,
        body: [String: Any]? = nil,
        type: T.Type = T.self
    ) async throws -> T {
        let url = baseURL + path
        return try await session.request(
            url,
            method: .put,
            parameters: body,
            encoding: JSONEncoding.default
        )
        .validate()
        .serializingDecodable(T.self)
        .value
    }

    func patch<T: Decodable>(
        path: String,
        body: [String: Any]? = nil,
        type: T.Type = T.self
    ) async throws -> T {
        let url = baseURL + path
        return try await session.request(
            url,
            method: .patch,
            parameters: body,
            encoding: JSONEncoding.default
        )
        .validate()
        .serializingDecodable(T.self)
        .value
    }

    func delete<T: Decodable>(
        path: String,
        body: [String: Any]? = nil,
        type: T.Type = T.self
    ) async throws -> T {
        let url = baseURL + path
        return try await session.request(
            url,
            method: .delete,
            parameters: body,
            encoding: JSONEncoding.default
        )
        .validate()
        .serializingDecodable(T.self)
        .value
    }

    /// Post with raw Encodable body
    func post<B: Encodable, T: Decodable>(
        path: String,
        encodable: B,
        type: T.Type = T.self
    ) async throws -> T {
        let url = baseURL + path
        return try await session.request(
            url,
            method: .post,
            parameters: encodable,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .serializingDecodable(T.self)
        .value
    }

    /// Put with raw Encodable body
    func put<B: Encodable, T: Decodable>(
        path: String,
        encodable: B,
        type: T.Type = T.self
    ) async throws -> T {
        let url = baseURL + path
        return try await session.request(
            url,
            method: .put,
            parameters: encodable,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .serializingDecodable(T.self)
        .value
    }

    /// Post that returns raw Data (for non-Decodable responses)
    func postRaw(
        path: String,
        body: [String: Any]? = nil
    ) async throws -> Data {
        let url = baseURL + path
        return try await session.request(
            url,
            method: .post,
            parameters: body,
            encoding: JSONEncoding.default
        )
        .validate()
        .serializingData()
        .value
    }

    /// Get raw response for manual parsing
    func getRaw(
        path: String,
        parameters: [String: Any]? = nil
    ) async throws -> Data {
        let url = baseURL + path
        return try await session.request(
            url,
            method: .get,
            parameters: parameters
        )
        .validate()
        .serializingData()
        .value
    }
}
