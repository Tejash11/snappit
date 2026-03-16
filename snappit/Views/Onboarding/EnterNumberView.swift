import SwiftUI

struct EnterNumberView: View {
    @EnvironmentObject private var appRouter: AppRouter
    @ObservedObject var viewModel: AuthViewModel

    @FocusState private var isPhoneFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Header
            VStack(spacing: 8) {
                Image(systemName: "cart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.green)

                Text("snappit")
                    .font(.title.bold())

                Text("Enter your phone number to continue")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.bottom, 40)

            // Phone Input
            VStack(spacing: 16) {
                HStack(spacing: 12) {
                    Text("+91")
                        .font(.title3.bold())
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 14)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                    TextField("Phone number", text: $viewModel.phone)
                        .font(.title3)
                        .keyboardType(.numberPad)
                        .textContentType(.telephoneNumber)
                        .focused($isPhoneFocused)
                        .onChange(of: viewModel.phone) { _, newValue in
                            // Limit to 10 digits
                            let filtered = newValue.filter { $0.isNumber }
                            if filtered.count > 10 {
                                viewModel.phone = String(filtered.prefix(10))
                            } else if filtered != newValue {
                                viewModel.phone = filtered
                            }
                        }
                        .padding(14)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal)

                // Error message
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                        .padding(.horizontal)
                }

                // Continue button
                Button {
                    Task {
                        let success = await viewModel.sendOtp()
                        if success {
                            appRouter.navigateTo(.enterOtp)
                        }
                    }
                } label: {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    } else {
                        Text("Continue")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                    }
                }
                .background(viewModel.phone.count == 10 ? Color.green : Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .disabled(viewModel.phone.count != 10 || viewModel.isLoading)
                .padding(.horizontal)
            }

            Spacer()

            // Skip / Guest login
            Button {
                Task {
                    await viewModel.guestLogin(appRouter: appRouter)
                }
            } label: {
                Text("Skip for now")
                    .font(.subheadline)
                    .foregroundStyle(.green)
            }
            .disabled(viewModel.isLoading)
            .padding(.bottom, 32)
        }
        .onAppear {
            isPhoneFocused = true
        }
    }
}
