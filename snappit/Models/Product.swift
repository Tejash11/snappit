import Foundation

struct Product: Identifiable, Codable {
    let id: Int
    let displayName: String
    let brand: String
    let itemCode: Int
    let categoryId: Int
    let subCategoryId: Int
    let categoryName: String
    let subCategoryName: String
    let mrp: Double
    let sellingPrice: Double
    let offerSellingPrice: Double?
    let maxSaleQty: Int
    let unitValue: Double
    let unit: String
    let imageUrl: String
    let images: [String]
    let description: String
    let offerId: String
    let isOutOfStock: Bool?
    let productType: String

    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "display_name"
        case brand
        case itemCode = "item_code"
        case categoryId = "category_id"
        case subCategoryId = "sub_category_id"
        case categoryName = "category_name"
        case subCategoryName = "sub_category_name"
        case mrp
        case sellingPrice = "selling_price"
        case offerSellingPrice = "offer_selling_price"
        case maxSaleQty = "max_sale_qty"
        case unitValue = "unit_value"
        case unit
        case imageUrl = "img_url"
        case images
        case description = "desc"
        case offerId = "offer_id"
        case isOutOfStock = "is_oos"
        case productType = "product_type"
    }

    /// The best available price (offer price > selling price > MRP)
    var effectivePrice: Double {
        offerSellingPrice ?? sellingPrice
    }

    /// Discount percentage from MRP
    var discountPercent: Int {
        guard mrp > 0, effectivePrice < mrp else { return 0 }
        return Int(((mrp - effectivePrice) / mrp) * 100)
    }

    /// Formatted weight/quantity string (e.g., "1 kg", "500 ml")
    var weightDisplay: String {
        if unitValue == Double(Int(unitValue)) {
            return "\(Int(unitValue)) \(unit)"
        }
        return "\(unitValue) \(unit)"
    }
}
