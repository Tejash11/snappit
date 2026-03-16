import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var cartViewModel: CartViewModel

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Delivery Header
                deliveryHeader

                // Category Scroll
                if !viewModel.categories.isEmpty {
                    categorySection
                }

                // Products Grid
                if viewModel.isLoading {
                    ProgressView("Loading products...")
                        .padding(.top, 40)
                } else {
                    productGrid
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Snappit in")
        .task {
            await viewModel.loadProducts()
        }
    }

    // MARK: - Delivery Header
    private var deliveryHeader: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    Text("Delivery in")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("10 minutes")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                }
                Text("Home — Andheri West")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            Spacer()
            Image(systemName: "person.circle")
                .font(.title2)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 8)
    }

    // MARK: - Category Section
    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Shop by Category")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(viewModel.categories) { category in
                        NavigationLink(value: category) {
                            VStack(spacing: 6) {
                                AsyncImage(url: URL(string: category.imageUrl)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    Circle()
                                        .fill(Color(.systemGray5))
                                        .overlay(
                                            Image(systemName: "leaf")
                                                .foregroundStyle(.green)
                                        )
                                }
                                .frame(width: 64, height: 64)
                                .clipShape(Circle())

                                Text(category.name)
                                    .font(.caption2)
                                    .foregroundStyle(.primary)
                                    .lineLimit(1)
                            }
                            .frame(width: 72)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Product Grid
    private var productGrid: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(viewModel.products) { product in
                ProductCardView(
                    product: product,
                    quantity: cartViewModel.quantity(for: product.id),
                    onAdd: { cartViewModel.addToCart(product: product) },
                    onRemove: { cartViewModel.removeFromCart(productId: product.id) }
                )
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(CartViewModel())
    }
}
