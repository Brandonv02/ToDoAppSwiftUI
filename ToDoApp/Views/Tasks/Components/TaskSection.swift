import SwiftUI

struct TaskSection: View {
    let title: String
    let tasks: [Task]
    let taskManager: TaskManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.horizontal, 4)
            
            ForEach(tasks) { task in
                NavigationLink(destination: TaskDetailView(task: task, taskManager: taskManager)) {
                    TaskRowView(task: task, taskManager: taskManager)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
