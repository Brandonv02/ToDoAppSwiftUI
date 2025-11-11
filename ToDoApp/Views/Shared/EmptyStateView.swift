import SwiftUI

struct EmptyStateView: View {
    let searchText: String
    let icon: String
    let emptyMessage: String
    let searchMessage: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: searchText.isEmpty ? icon : "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            Text(searchText.isEmpty ? emptyMessage : searchMessage)
                .font(.title3)
                .fontWeight(.semibold)
            Text(searchText.isEmpty ? "Toca el botón + para crear" : "Intenta con otra búsqueda")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top, 60)
    }
}
