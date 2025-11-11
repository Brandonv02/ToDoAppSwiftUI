import SwiftUI

struct TaskDetailView: View {
    let task: Task
    @ObservedObject var taskManager: TaskManager
    @Environment(\.dismiss) var dismiss
    
    @State private var isEditing = false
    @State private var editedTitle: String
    @State private var editedNotes: String
    @State private var editedDueDate: Date
    @State private var hasReminder: Bool
    @State private var showingDeleteAlert = false
    
    init(task: Task, taskManager: TaskManager) {
        self.task = task
        self.taskManager = taskManager
        _editedTitle = State(initialValue: task.title)
        _editedNotes = State(initialValue: task.notes)
        _editedDueDate = State(initialValue: task.dueDate ?? Date())
        _hasReminder = State(initialValue: task.dueDate != nil)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "clock")
                        .font(.title2)
                        .foregroundColor(task.isCompleted ? .green : .orange)
                    Text(task.isCompleted ? "Completada" : "Pendiente")
                        .font(.headline)
                    Spacer()
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 16) {
                    if isEditing {
                        TextField("Título", text: $editedTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Notas", text: $editedNotes, axis: .vertical)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .lineLimit(5...10)
                        
                        Toggle("Recordatorio", isOn: $hasReminder)
                        
                        if hasReminder {
                            DatePicker("Fecha y hora", selection: $editedDueDate, in: Date()...)
                        }
                    } else {
                        Text(task.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        if !task.notes.isEmpty {
                            Text(task.notes)
                                .foregroundColor(.secondary)
                        }
                        
                        if let dueDate = task.dueDate {
                            HStack {
                                Image(systemName: "bell.fill")
                                    .foregroundColor(.purple)
                                VStack(alignment: .leading) {
                                    Text(dueDate, style: .date)
                                    Text(dueDate, style: .time)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                            .background(Color.purple.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(12)
                
                VStack(spacing: 12) {
                    Button(action: { taskManager.toggleComplete(task) }) {
                        Label(task.isCompleted ? "Marcar como pendiente" : "Marcar como completada",
                              systemImage: task.isCompleted ? "arrow.uturn.backward.circle" : "checkmark.circle")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(task.isCompleted ? Color.orange : Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: { showingDeleteAlert = true }) {
                        Label("Eliminar tarea", systemImage: "trash")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
            }
            .padding()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.1), Color.blue.opacity(0.1)]),
                                  startPoint: .topLeading,
                                  endPoint: .bottomTrailing))
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Guardar" : "Editar") {
                    if isEditing {
                        let updatedTask = Task(
                            id: task.id,
                            title: editedTitle,
                            notes: editedNotes,
                            dueDate: hasReminder ? editedDueDate : nil,
                            isCompleted: task.isCompleted
                        )
                        taskManager.updateTask(updatedTask)
                    }
                    isEditing.toggle()
                }
                .disabled(isEditing && editedTitle.isEmpty)
            }
        }
        .alert("Eliminar tarea", isPresented: $showingDeleteAlert) {
            Button("Cancelar", role: .cancel) { }
            Button("Eliminar", role: .destructive) {
                taskManager.deleteTask(task)
                dismiss()
            }
        } message: {
            Text("¿Estás seguro de que quieres eliminar esta tarea?")
        }
    }
}
