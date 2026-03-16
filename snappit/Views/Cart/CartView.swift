import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartViewModel: CartViewModel

    var body: some View {
        Group {
            if cartViewModel.items.isEmpty {
                emptyCartView
            } else {
                cartListView
            }
        }
        .navigationTitle("Cart")
    }

    // MARK: - Empty Cart
    private var emptyCartView: some View {
        VStack(spacing: 16) {
            Image(systemName: "cart")
                .font(.system(size: 60))
                .foregroundStyle(.gray)
            Text("Your cart is empty")
                .font(.title3)
                .fontWeight(.semibold)
            Text("Add items from the home screen to get started")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }

    // MARK: - Cart List
    private var cartListView: some View {
        VStack(spacing: 0) {
            List {
                ForEach(cartViewModel.items) { item in
                    cartItemRow(item)
                }
            }
            .listStyle(.plain)

            // Bottom Summary
            VStack(spacing: 12) {
                Divider()

                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(cartViewModel.totalItems) items")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text("₹\(Int(cartViewModel.totalPrice))")
                            .font(.title3)
                            .fontWeight(.bold)
                    }

                    Spacer()

                    Button(action: {}) {
                        Text("Checkout")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 12)
                            .background(Color.green)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
            .background(Color(.systemBackground))
        }
    }

    // MARK: - Cart Item Row
    private func cartItemRow(_ item: CartItem) -> some View {
        HStack(spacing: 12) {
            // Product Image
            AsyncImage(url: URL(string: item.mainImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color(.systemGray5))
                    .overlay(
                        Image(systemName: "photo")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    )
            }
            .frame(width: 56, height: 56)
            .clipShape(RoundedRectangle(cornerRadius: 6))

            // Product Info
            VStack(alignment: .leading, spacing: 4) {
                Text(item.productName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(2)

                Text(item.weightDisplay)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                HStack(spacing: 4) {
                    Text("₹\(Int(item.effectivePrice))")
                        .font(.subheadline)
                        .fontWeight(.bold)

                    if item.effectivePrice < item.mrp {
                        Text("₹\(Int(item.mrp))")
                            .font(.caption)
                            .strikethrough()
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Spacer()

            // Quantity Stepper
            HStack(spacing: 0) {
                Button {
                    cartViewModel.removeFromCart(productId: item.id)
                } label: {
                    Image(systemName: "minus")
                        .font(.caption)
                        .fontWeight(.bold)
                        .frame(width: 28, height: 28)
                }

                Text("\(item.inCartQuantity)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(minWidth: 24)

                Button {
                    cartViewModel.incrementItem(productId: item.id)
                } label: {
                    Image(systemName: "plus")
                        .font(.caption)
                        .fontWeight(.bold)
                        .frame(width: 28, height: 28)
                }
            }
            .foregroundStyle(.white)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        CartView()
            .environmentObject(CartViewModel())
    }
}
