import SwiftUI

struct NotificationPermissionView: View {
    @EnvironmentObject private var appRouter: AppRouter
    @ObservedObject var viewModel: OnboardingPermissionViewModel

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Illustration
            ZStack {
                Circle()
                    .fill(Color(.systemGray6))
                    .frame(width: 140, height: 140)

                Image(systemName: "bell.badge.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.green)
            }
            .padding(.bottom, 32)

            // Title
            Text("Get Live Order Updates")
                .font(.title2.bold())
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.bottom, 12)

            // Subtitle
            Text("Turn on notifications to never miss order updates, offers & more...")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()

            // Primary CTA
            Button {
                Task {
                    _ = await viewModel.requestNotificationPermission()
                    completeOnboarding()
                }
            } label: {
                Text("Allow Notifications")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            .padding(.bottom, 12)

            // Secondary CTA
            Button {
                completeOnboarding()
            } label: {
                Text("Maybe Later")
                    .font(.headline)
                    .foregroundStyle(.green)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .background(Color.green.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
        .background(Color(.systemBackground).ignoresSafeArea())
    }

    private func completeOnboarding() {
        viewModel.markOnboardingComplete()
        appRouter.navigateTo(.home)
    }
}
