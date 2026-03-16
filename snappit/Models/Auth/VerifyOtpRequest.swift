import Foundation

struct VerifyOtpRequest: Encodable {
    let accountId: Int
    let clientApp: String
    let countryCode: String
    let otp: String
    let phone: String
    let token: String

    enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case clientApp = "client_app"
        case countryCode = "country_code"
        case otp
        case phone
        case token
    }
}
