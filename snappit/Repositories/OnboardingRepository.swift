import Foundation

final class OnboardingRepository: BaseRepository {

    func getToken() -> String? {
        tokenStore.token
    }

    func sendOtp(request: SendOtpRequest) async throws -> SendOtpResponse {
        try await http.post(
            path: APIPaths.sendPhoneOtp,
            encodable: request,
            type: SendOtpResponse.self
        )
    }

    func verifyOtp(request: VerifyOtpRequest) async throws -> VerifyOtpResponse {
        let response: VerifyOtpResponse = try await http.post(
            path: APIPaths.verifyOtp,
            encodable: request,
            type: VerifyOtpResponse.self
        )
        updateUserData(response.userData.toUserCacheData(), token: response.token)
        onUserLogin(response.userData.toUserCacheData())
        return response
    }

    func guestLogin() async throws -> VerifyOtpResponse {
        let response: VerifyOtpResponse = try await http.put(
            path: APIPaths.guestLogin,
            type: VerifyOtpResponse.self
        )
        updateUserData(response.userData.toUserCacheData(), token: response.token)
        onUserLogin(response.userData.toUserCacheData())
        return response
    }
}
