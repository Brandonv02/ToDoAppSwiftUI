import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var taskManager: TaskManager
    
    @State private var title = ""
    @State private var notes = ""
    @State private var dueDate = Date()
    @State private var hasReminder = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Información")) {
                    TextField("Título de la tarea", text: $title)
                    TextField("Notas (opcional)", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section(header: Text("Recordatorio")) {
                    Toggle("Programar recordatorio", isOn: $hasReminder)
                    
                    if hasReminder {
                        DatePicker("Fecha y hora", selection: $dueDate, in: Date()...)
                    }
                }
            }
            .navigationTitle("Nueva Tarea")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        let task = Task(
                            title: title,
                            notes: notes,
                            dueDate: hasReminder ? dueDate : nil,
                            isCompleted: false
                        )
                        taskManager.addTask(task)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                    .fontWeight(.semibold)
                }
            }
        }
    }
}
