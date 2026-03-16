import Foundation

struct SendOtpRequest: Encodable {
    let clientApp: String
    let countryCode: String
    let phone: String

    enum CodingKeys: String, CodingKey {
        case clientApp = "client_app"
        case countryCode = "country_code"
        case phone
    }

    static func consumer(phone: String) -> SendOtpRequest {
        SendOtpRequest(clientApp: "consumer", countryCode: "+91", phone: phone)
    }
}
