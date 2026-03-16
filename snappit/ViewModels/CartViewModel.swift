import SwiftUI
import Combine

@MainActor
class CartViewModel: ObservableObject {
    @Published var items: [CartItem] = []

    /// Total number of items in cart (sum of all quantities)
    var totalItems: Int {
        items.reduce(0) { $0 + $1.inCartQuantity }
    }

    /// Total price of all items in cart
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.lineTotal }
    }

    /// Total MRP (for showing savings)
    var totalMRP: Double {
        items.reduce(0) { $0 + (Double($1.inCartQuantity) * $1.mrp) }
    }

    /// Total savings
    var totalSavings: Double {
        totalMRP - totalPrice
    }

    /// Get quantity for a specific product
    func quantity(for productId: Int) -> Int {
        items.first { $0.id == productId }?.inCartQuantity ?? 0
    }

    /// Add a product to cart (or increment if already exists)
    func addToCart(product: Product) {
        if let index = items.firstIndex(where: { $0.id == product.id }) {
            guard items[index].inCartQuantity < items[index].maxAvailableQty else { return }
            items[index].inCartQuantity += 1
        } else {
            let cartItem = CartItem.fromProduct(product, quantity: 1)
            items.append(cartItem)
        }
    }

    /// Remove one quantity from cart (removes item entirely if quantity reaches 0)
    func removeFromCart(productId: Int) {
        guard let index = items.firstIndex(where: { $0.id == productId }) else { return }

        if items[index].inCartQuantity > 1 {
            items[index].inCartQuantity -= 1
        } else {
            items.remove(at: index)
        }
    }

    /// Increment quantity for an existing cart item
    func incrementItem(productId: Int) {
        guard let index = items.firstIndex(where: { $0.id == productId }) else { return }
        guard items[index].inCartQuantity < items[index].maxAvailableQty else { return }
        items[index].inCartQuantity += 1
    }

    /// Clear the entire cart
    func clearCart() {
        items.removeAll()
    }
}
