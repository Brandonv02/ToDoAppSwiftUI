import SwiftUI

enum TransactionType: String, Codable, CaseIterable {
    case income = "Ingreso"
    case expense = "Gasto"
    
    var icon: String {
        switch self {
        case .income: return "arrow.down.circle.fill"
        case .expense: return "arrow.up.circle.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .income: return .green
        case .expense: return .red
        }
    }
}
