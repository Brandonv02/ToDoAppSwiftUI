import SwiftUI

struct TransactionDetailView: View {
    let transaction: Transaction
    @ObservedObject var financeManager: FinanceManager
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header con monto
                VStack(spacing: 8) {
                    Image(systemName: transaction.type.icon)
                        .font(.system(size: 50))
                        .foregroundColor(transaction.type.color)
                    
                    Text("$\(transaction.amount, specifier: "%.2f")")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(transaction.type.color)
                    
                    Text(transaction.type.rawValue)
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(12)
                
                // Detalles
                VStack(alignment: .leading, spacing: 16) {
                    DetailRow(icon: "text.alignleft", title: "Concepto", value: transaction.title)
                    DetailRow(icon: "tag.fill", title: "Categoría", value: transaction.category)
                    DetailRow(icon: "calendar", title: "Fecha", value: transaction.date.formatted(date: .long, time: .omitted))
                    
                    if !transaction.notes.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Image(systemName: "note.text")
                                    .foregroundColor(.purple)
                                Text("Notas")
                                    .font(.headline)
                            }
                            Text(transaction.notes)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(12)
                
                // Botón eliminar
                Button(action: { showingDeleteAlert = true }) {
                    Label("Eliminar transacción", systemImage: "trash")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.1), Color.blue.opacity(0.1)]),
                                  startPoint: .topLeading,
                                  endPoint: .bottomTrailing))
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Eliminar transacción", isPresented: $showingDeleteAlert) {
            Button("Cancelar", role: .cancel) { }
            Button("Eliminar", role: .destructive) {
                financeManager.deleteTransaction(transaction)
                dismiss()
            }
        } message: {
            Text("¿Estás seguro de que quieres eliminar esta transacción?")
        }
    }
}
