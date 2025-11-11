
import SwiftUI

struct ContentView: View {
    @StateObject private var taskManager = TaskManager()
    @StateObject private var financeManager = FinanceManager()
    
    var body: some View {
        TabView {
            TasksView(taskManager: taskManager)
                .tabItem {
                    Label("Tareas", systemImage: "checklist")
                }
            
            FinanceView(financeManager: financeManager)
                .tabItem {
                    Label("Finanzas", systemImage: "dollarsign.circle.fill")
                }
        }
        .accentColor(.purple)
    }
}
