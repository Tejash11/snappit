import Foundation

struct VerifyOtpResponse: Decodable {
    let isActive: Bool
    let token: String
    let userData: UserProfile

    enum CodingKeys: String, CodingKey {
        case isActive = "is_active"
        case token
        case userData = "user_data"
    }
}
