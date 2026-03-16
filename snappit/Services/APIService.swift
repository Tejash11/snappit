import Foundation

class APIService {
    static let shared = APIService()

    private init() {}

    /// Load products from local JSON file (same pattern as a real API call — just swap data source later)
    func loadProducts() async throws -> [Product] {
        guard let url = Bundle.main.url(forResource: "sample_products", withExtension: "json") else {
            throw LocalAPIError.fileNotFound
        }

        let data = try Data(contentsOf: url)
        let products = try JSONDecoder().decode([Product].self, from: data)
        return products
    }

    /// Extract unique categories from products (simulates a category API)
    func loadCategories(from products: [Product]) -> [Category] {
        var seen = Set<Int>()
        var categories: [Category] = []

        for product in products {
            if !seen.contains(product.categoryId) {
                seen.insert(product.categoryId)
                categories.append(
                    Category(
                        id: product.categoryId,
                        name: product.categoryName,
                        imageUrl: product.imageUrl
                    )
                )
            }
        }
        return categories
    }
}

enum LocalAPIError: LocalizedError {
    case fileNotFound
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Could not find the data file."
        case .decodingFailed:
            return "Could not read the data."
        }
    }
}
