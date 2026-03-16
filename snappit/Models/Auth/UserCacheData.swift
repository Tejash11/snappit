import Foundation

struct UserCacheData: Codable {
    let userId: Int
    let name: String?
    let phone: String?
    let email: String?
    let countryCode: String?
    let gender: String?
    let dob: String?
    let userImage: String?
    let onBoardingVia: String?

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name, phone, email
        case countryCode = "country_code"
        case gender, dob
        case userImage = "user_image"
        case onBoardingVia = "on_boarding_via"
    }
}
