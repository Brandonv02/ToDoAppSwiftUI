import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var notes: String
    var dueDate: Date?
    var isCompleted: Bool
    var notificationId: String?
    
    init(id: UUID = UUID(), title: String, notes: String = "", dueDate: Date? = nil, isCompleted: Bool = false, notificationId: String? = nil) {
        self.id = id
        self.title = title
        self.notes = notes
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.notificationId = notificationId
    }
}
