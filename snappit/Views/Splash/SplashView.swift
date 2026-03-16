import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var appRouter: AppRouter
    @StateObject private var viewModel = SplashViewModel()

    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "cart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.white)

                Text("snappit")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.white)

                Text("Groceries in minutes")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
            }
        }
        .task {
            await viewModel.determineRoute(appRouter: appRouter)
        }
    }
}
