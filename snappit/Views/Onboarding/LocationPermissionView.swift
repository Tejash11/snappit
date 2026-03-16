import SwiftUI
import CoreLocation

struct LocationPermissionView: View {
    @EnvironmentObject private var appRouter: AppRouter
    @ObservedObject var viewModel: OnboardingPermissionViewModel

    @State private var hasRequestedPermission = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Illustration
            ZStack {
                Circle()
                    .fill(Color(red: 0.92, green: 0.92, blue: 1.0))
                    .frame(width: 140, height: 140)

                Image(systemName: "location.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.green)
            }
            .padding(.bottom, 32)

            // Title
            Text("Allow Location Access to Deliver at your Doorstep!")
                .font(.title2.bold())
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.bottom, 12)

            // Subtitle
            Text("Please enable location access so we can find a store near you.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()

            // Primary CTA
            Button {
                hasRequestedPermission = true
                viewModel.requestLocationPermission()
            } label: {
                Text("Allow Location Access")
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
                appRouter.navigateTo(.notificationPermission)
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
        .background(
            LinearGradient(
                colors: [.white, Color(red: 0.92, green: 0.92, blue: 1.0)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .onChange(of: viewModel.locationStatus) { _, newStatus in
            guard hasRequestedPermission else { return }
            if newStatus != .notDetermined {
                appRouter.navigateTo(.notificationPermission)
            }
        }
    }
}
