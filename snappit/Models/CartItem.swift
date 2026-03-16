import Foundation

struct CartItem: Identifiable, Codable {
    let id: Int
    let productItemCode: Int
    let productName: String
    let sellingPrice: Double
    let mrp: Double
    let maxAvailableQty: Int
    let mainImage: String
    let offerPrice: Double?
    var inCartQuantity: Int
    let categoryName: String
    let subCategoryName: String
    let unitValue: Double
    let unit: String
    let offerId: String
    let isOutOfStock: Bool

    /// The best available price
    var effectivePrice: Double {
        offerPrice ?? sellingPrice
    }

    /// Line total for this cart item
    var lineTotal: Double {
        effectivePrice * Double(inCartQuantity)
    }

    /// Formatted weight/quantity string
    var weightDisplay: String {
        if unitValue == Double(Int(unitValue)) {
            return "\(Int(unitValue)) \(unit)"
        }
        return "\(unitValue) \(unit)"
    }

    /// Create a CartItem from a Product
    static func fromProduct(_ product: Product, quantity: Int = 1) -> CartItem {
        CartItem(
            id: product.id,
            productItemCode: product.itemCode,
            productName: product.displayName,
            sellingPrice: product.sellingPrice,
            mrp: product.mrp,
            maxAvailableQty: product.maxSaleQty,
            mainImage: product.imageUrl,
            offerPrice: product.offerSellingPrice,
            inCartQuantity: quantity,
            categoryName: product.categoryName,
            subCategoryName: product.subCategoryName,
            unitValue: product.unitValue,
            unit: product.unit,
            offerId: product.offerId,
            isOutOfStock: product.isOutOfStock ?? false
        )
    }
}
