import SwiftUI

struct CategoriesView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "square.grid.2x2")
                .font(.largeTitle)
                .foregroundStyle(.green)
            Text("Categories")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Browse products by category")
                .foregroundStyle(.secondary)
        }
        .navigationTitle("Categories")
    }
}

#Preview {
    NavigationStack {
        CategoriesView()
    }
}
