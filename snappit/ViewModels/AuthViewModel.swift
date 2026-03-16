import SwiftUI
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    @Published var phone: String = ""
    @Published var otp: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var otpTimerSeconds: Int = 0

    // Data passed between screens
    var accountId: Int = 0
    var sendOtpToken: String = ""

    private var timerCancellable: AnyCancellable?
    private let repo: OnboardingRepository = singleton()

    // MARK: - Send OTP

    func sendOtp() async -> Bool {
        guard phone.count == 10 else {
            errorMessage = "Please enter a valid 10-digit phone number"
            return false
        }

        isLoading = true
        errorMessage = nil

        do {
            let request = SendOtpRequest.consumer(phone: phone)
            let response = try await repo.sendOtp(request: request)
            accountId = response.accountId
            sendOtpToken = response.token
            startOtpTimer()
            isLoading = false
            return true
        } catch {
            print("[Snappit] sendOtp failed: \(error)")
            errorMessage = (error as? APIError)?.userFriendlyMessage ?? "Something went wrong. Please try again."
            isLoading = false
            return false
        }
    }

    // MARK: - Verify OTP

    func verifyOtp(appRouter: AppRouter) async {
        guard otp.count == 6 else {
            errorMessage = "Please enter the 6-digit OTP"
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let request = VerifyOtpRequest(
                accountId: accountId,
                clientApp: "consumer",
                countryCode: "+91",
                otp: otp,
                phone: phone,
                token: sendOtpToken
            )
            _ = try await repo.verifyOtp(request: request)
            if OnboardingPermissionViewModel.shouldShowOnboarding() {
                appRouter.navigateTo(.locationPermission)
            } else {
                appRouter.navigateTo(.home)
            }
        } catch {
            errorMessage = (error as? APIError)?.userFriendlyMessage ?? "Invalid OTP. Please try again."
        }

        isLoading = false
    }

    // MARK: - Resend OTP

    func resendOtp() async {
        isLoading = true
        errorMessage = nil

        do {
            let request = SendOtpRequest.consumer(phone: phone)
            let response = try await repo.sendOtp(request: request)
            accountId = response.accountId
            sendOtpToken = response.token
            otp = ""
            startOtpTimer()
        } catch {
            errorMessage = (error as? APIError)?.userFriendlyMessage ?? "Failed to resend OTP."
        }

        isLoading = false
    }

    // MARK: - Guest Login

    func guestLogin(appRouter: AppRouter) async {
        isLoading = true
        errorMessage = nil

        do {
            _ = try await repo.guestLogin()
            if OnboardingPermissionViewModel.shouldShowOnboarding() {
                appRouter.navigateTo(.locationPermission)
            } else {
                appRouter.navigateTo(.home)
            }
        } catch {
            errorMessage = (error as? APIError)?.userFriendlyMessage ?? "Something went wrong. Please try again."
        }

        isLoading = false
    }

    // MARK: - Timer

    private func startOtpTimer() {
        otpTimerSeconds = 20
        timerCancellable?.cancel()
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                if self.otpTimerSeconds > 0 {
                    self.otpTimerSeconds -= 1
                } else {
                    self.timerCancellable?.cancel()
                }
            }
    }

    var canResendOtp: Bool {
        otpTimerSeconds == 0
    }

    var otpSent: Bool {
        !sendOtpToken.isEmpty
    }
}
