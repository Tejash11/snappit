import SwiftUI

struct OrdersView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "bag")
                .font(.largeTitle)
                .foregroundStyle(.green)
            Text("Orders")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Your order history will appear here")
                .foregroundStyle(.secondary)
        }
        .navigationTitle("Orders")
    }
}

#Preview {
    NavigationStack {
        OrdersView()
    }
}
