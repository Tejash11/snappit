import Foundation

struct SendOtpResponse: Decodable {
    let token: String
    let accountId: Int
    let forgotPwd: Bool

    enum CodingKeys: String, CodingKey {
        case token
        case accountId = "account_id"
        case forgotPwd = "forgot_pwd"
    }
}
