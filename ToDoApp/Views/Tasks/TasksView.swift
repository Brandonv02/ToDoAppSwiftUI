import SwiftUI

struct TasksView: View {
    @ObservedObject var taskManager: TaskManager
    @State private var showingAddTask = false
    @State private var searchText = ""
    
    var filteredTasks: [Task] {
        if searchText.isEmpty {
            return taskManager.tasks
        }
        return taskManager.tasks.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    var pendingTasks: [Task] {
        filteredTasks.filter { !$0.isCompleted }
    }
    
    var completedTasks: [Task] {
        filteredTasks.filter { $0.isCompleted }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.1), Color.blue.opacity(0.1)]),
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HStack(spacing: 20) {
                        StatCard(title: "Pendientes", count: pendingTasks.count, color: .orange)
                        StatCard(title: "Completadas", count: completedTasks.count, color: .green)
                    }
                    .padding()
                    
                    ScrollView {
                        VStack(spacing: 16) {
                            if !pendingTasks.isEmpty {
                                TaskSection(title: "Pendientes", tasks: pendingTasks, taskManager: taskManager)
                            }
                            
                            if !completedTasks.isEmpty {
                                TaskSection(title: "Completadas", tasks: completedTasks, taskManager: taskManager)
                            }
                            
                            if filteredTasks.isEmpty {
                                EmptyStateView(searchText: searchText, icon: "checkmark.circle", emptyMessage: "¡No hay tareas!", searchMessage: "No se encontraron tareas")
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Mis Tareas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.purple)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Buscar tareas...")
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(taskManager: taskManager)
            }
        }
    }
}
