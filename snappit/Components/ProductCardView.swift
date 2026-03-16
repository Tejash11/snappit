import SwiftUI

struct ProductCardView: View {
    let product: Product
    let quantity: Int
    let onAdd: () -> Void
    let onRemove: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Product Image
            AsyncImage(url: URL(string: product.imageUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray5))
                    .overlay(
                        Image(systemName: "photo")
                            .font(.title2)
                            .foregroundStyle(.gray)
                    )
            }
            .frame(height: 120)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            // Product Name
            Text(product.displayName)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            // Weight
            Text(product.weightDisplay)
                .font(.caption)
                .foregroundStyle(.secondary)

            // Price Row
            HStack(spacing: 4) {
                Text("₹\(Int(product.effectivePrice))")
                    .font(.subheadline)
                    .fontWeight(.bold)

                if product.discountPercent > 0 {
                    Text("₹\(Int(product.mrp))")
                        .font(.caption)
                        .strikethrough()
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            // Add / Quantity Stepper
            if quantity == 0 {
                Button(action: onAdd) {
                    Text("ADD")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.green, lineWidth: 1.5)
                        )
                }
            } else {
                HStack {
                    Button(action: onRemove) {
                        Image(systemName: "minus")
                            .font(.caption)
                            .fontWeight(.bold)
                    }

                    Text("\(quantity)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .frame(minWidth: 24)

                    Button(action: onAdd) {
                        Image(systemName: "plus")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding(12)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
}
