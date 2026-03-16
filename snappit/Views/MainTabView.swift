import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var cartViewModel: CartViewModel

    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            NavigationStack {
                CategoriesView()
            }
            .tabItem {
                Label("Categories", systemImage: "square.grid.2x2")
            }

            NavigationStack {
                CartView()
            }
            .tabItem {
                Label("Cart", systemImage: "cart.fill")
            }
            .badge(cartViewModel.totalItems)

            NavigationStack {
                OrdersView()
            }
            .tabItem {
                Label("Orders", systemImage: "bag.fill")
            }

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
        .tint(.green)
    }
}

#Preview {
    MainTabView()
        .environmentObject(CartViewModel())
}

