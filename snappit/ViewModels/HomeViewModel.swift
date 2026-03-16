import SwiftUI
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var categories: [Category] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiService = APIService.shared

    func loadProducts() async {
        isLoading = true
        errorMessage = nil

        do {
            let loadedProducts = try await apiService.loadProducts()
            products = loadedProducts
            categories = apiService.loadCategories(from: loadedProducts)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
