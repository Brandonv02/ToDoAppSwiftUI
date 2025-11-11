import Foundation

struct Transaction: Identifiable, Codable {
    let id: UUID
    var title: String
    var amount: Double
    var type: TransactionType
    var category: String
    var date: Date
    var notes: String
    
    init(id: UUID = UUID(), title: String, amount: Double, type: TransactionType, category: String, date: Date = Date(), notes: String = "") {
        self.id = id
        self.title = title
        self.amount = amount
        self.type = type
        self.category = category
        self.date = date
        self.notes = notes
    }
}
