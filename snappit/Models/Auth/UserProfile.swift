import Foundation

struct UserProfile: Decodable {
    let userId: Int
    let name: String?
    let phone: String?
    let email: String?
    let countryCode: String?
    let gender: String?
    let dob: String?
    let userImage: String?
    let isAddressSaved: Bool?
    let onBoardingVia: String?

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name, phone, email
        case countryCode = "country_code"
        case gender, dob
        case userImage = "user_image"
        case isAddressSaved = "is_address_saved"
        case onBoardingVia = "on_boarding_via"
    }

    func toUserCacheData() -> UserCacheData {
        UserCacheData(
            userId: userId,
            name: name,
            phone: phone,
            email: email,
            countryCode: countryCode,
            gender: gender,
            dob: dob,
            userImage: userImage,
            onBoardingVia: onBoardingVia
        )
    }
}
