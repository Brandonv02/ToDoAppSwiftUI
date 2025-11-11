import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var financeManager: FinanceManager
    
    @State private var title = ""
    @State private var amount = ""
    @State private var type: TransactionType = .expense
    @State private var category = ""
    @State private var date = Date()
    @State private var notes = ""
    
    let expenseCategories = ["Comida", "Transporte", "Entretenimiento", "Salud", "Servicios", "Compras", "Otro"]
    let incomeCategories = ["Salario", "Freelance", "Inversiones", "Regalo", "Venta", "Otro"]
    
    var categories: [String] {
        type == .income ? incomeCategories : expenseCategories
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tipo")) {
                    Picker("Tipo de transacción", selection: $type) {
                        ForEach(TransactionType.allCases, id: \.self) { type in
                            HStack {
                                Image(systemName: type.icon)
                                Text(type.rawValue)
                            }
                            .tag(type)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Información")) {
                    TextField("Concepto", text: $title)
                    
                    TextField("Monto", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Categoría", selection: $category) {
                        ForEach(categories, id: \.self) { cat in
                            Text(cat).tag(cat)
                        }
                    }
                    .onAppear {
                        if category.isEmpty {
                            category = categories.first ?? ""
                        }
                    }
                    
                    DatePicker("Fecha", selection: $date, displayedComponents: .date)
                    
                    TextField("Notas (opcional)", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Nueva Transacción")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Guardar") {
                        if let amountValue = Double(amount.replacingOccurrences(of: ",", with: ".")) {
                            let transaction = Transaction(
                                title: title,
                                amount: amountValue,
                                type: type,
                                category: category,
                                date: date,
                                notes: notes
                            )
                            financeManager.addTransaction(transaction)
                            dismiss()
                        }
                    }
                    .disabled(title.isEmpty || amount.isEmpty)
                    .fontWeight(.semibold)
                }
            }
        }
    }
}
