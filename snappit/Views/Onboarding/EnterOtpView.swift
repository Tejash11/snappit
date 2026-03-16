import SwiftUI

struct EnterOtpView: View {
    @EnvironmentObject private var appRouter: AppRouter
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 0) {
            // Back button
            HStack {
                Button {
                    viewModel.otp = ""
                    viewModel.errorMessage = nil
                    appRouter.navigateTo(.enterNumber)
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3.bold())
                        .foregroundStyle(.primary)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            // Top-aligned content
            VStack(alignment: .leading, spacing: 16) {
                Text("Enter OTP")
                    .font(.system(size: 20, weight: .semibold))

                Text("Please enter the OTP we have sent to your mobile number +91 \(viewModel.phone)")
                    .font(.system(size: 15))
                    .foregroundStyle(.secondary)

                OTPFieldView(otp: $viewModel.otp)
                    .padding(.top, 8)

                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                }

                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView("Verifying...")
                        Spacer()
                    }
                }

                // Resend OTP
                HStack {
                    Spacer()
                    if viewModel.canResendOtp {
                        Button {
                            Task {
                                await viewModel.resendOtp()
                            }
                        } label: {
                            Text("Resend OTP")
                                .font(.subheadline.bold())
                                .foregroundStyle(.green)
                        }
                        .disabled(viewModel.isLoading)
                    } else {
                        Text("Resend OTP in \(viewModel.otpTimerSeconds)s")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 16)

            Spacer()

            // Bottom-pinned section
            VStack(spacing: 12) {
                Button {
                    Task {
                        await viewModel.verifyOtp(appRouter: appRouter)
                    }
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 53)
                }
                .background(viewModel.otp.count == 6 ? Color.green : Color.gray.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .disabled(viewModel.otp.count != 6 || viewModel.isLoading)

                Text("By continuing, you agree to our Terms of Service & Privacy Policy")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .onChange(of: viewModel.otp) { _, newValue in
            if newValue.count == 6 {
                Task {
                    await viewModel.verifyOtp(appRouter: appRouter)
                }
            }
        }
    }
}
