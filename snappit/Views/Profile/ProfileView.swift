import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.green)
            Text("Profile")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Manage your account settings")
                .foregroundStyle(.secondary)
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
