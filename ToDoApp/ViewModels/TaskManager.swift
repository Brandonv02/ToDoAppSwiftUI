import Foundation
import SwiftUI
import UserNotifications
import Combine

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []
    private let saveKey = "SavedTasks"
    
    init() {
        loadTasks()
        requestNotificationPermission()
    }
    
    func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = decoded
        }
    }
    
    func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func addTask(_ task: Task) {
        var newTask = task
        if let dueDate = task.dueDate {
            newTask.notificationId = scheduleNotification(for: newTask, at: dueDate)
        }
        tasks.insert(newTask, at: 0)
        saveTasks()
    }
    
    func updateTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            if let oldNotificationId = tasks[index].notificationId {
                cancelNotification(id: oldNotificationId)
            }
            
            var updatedTask = task
            if let dueDate = task.dueDate, !task.isCompleted {
                updatedTask.notificationId = scheduleNotification(for: updatedTask, at: dueDate)
            }
            
            tasks[index] = updatedTask
            saveTasks()
        }
    }
    
    func deleteTask(_ task: Task) {
        if let notificationId = task.notificationId {
            cancelNotification(id: notificationId)
        }
        tasks.removeAll { $0.id == task.id }
        saveTasks()
    }
    
    func toggleComplete(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            if tasks[index].isCompleted, let notificationId = tasks[index].notificationId {
                cancelNotification(id: notificationId)
            }
            saveTasks()
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permiso de notificaciones concedido")
            }
        }
    }
    
    func scheduleNotification(for task: Task, at date: Date) -> String {
        let content = UNMutableNotificationContent()
        content.title = "⏰ Tarea Pendiente"
        content.body = task.title
        content.sound = .default
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let notificationId = UUID().uuidString
        let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error al programar notificación: \(error)")
            }
        }
        
        return notificationId
    }
    
    func cancelNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
