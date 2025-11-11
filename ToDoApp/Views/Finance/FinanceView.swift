import SwiftUI

struct FinanceView: View {
    @ObservedObject var financeManager: FinanceManager
    @State private var showingAddTransaction = false
    @State private var searchText = ""
    
    var filteredTransactions: [Transaction] {
        if searchText.isEmpty {
            return financeManager.transactions
        }
        return financeManager.transactions.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.category.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.1), Color.blue.opacity(0.1)]),
                             startPoint: .topLeading,
                             endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Resumen Financiero
                    VStack(spacing: 16) {
                        // Balance Total
                        VStack(spacing: 8) {
                            Text("Balance Total")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("$\(financeManager.balance, specifier: "%.2f")")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(financeManager.balance >= 0 ? .green : .red)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                        
                        // Ingresos y Gastos
                        HStack(spacing: 16) {
                            FinanceStatCard(
                                title: "Ingresos",
                                amount: financeManager.totalIncome,
                                color: .green,
                                icon: "arrow.down.circle.fill"
                            )
                            
                            FinanceStatCard(
                                title: "Gastos",
                                amount: financeManager.totalExpenses,
                                color: .red,
                                icon: "arrow.up.circle.fill"
                            )
                        }
                    }
                    .padding()
                    
                    // Lista de Transacciones
                    ScrollView {
                        VStack(spacing: 12) {
                            if filteredTransactions.isEmpty {
                                EmptyStateView(
                                    searchText: searchText,
                                    icon: "dollarsign.circle",
                                    emptyMessage: "No hay transacciones",
                                    searchMessage: "No se encontraron transacciones"
                                )
                            } else {
                                ForEach(filteredTransactions) { transaction in
                                    NavigationLink(destination: TransactionDetailView(transaction: transaction, financeManager: financeManager)) {
                                        TransactionRowView(transaction: transaction)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Mis Finanzas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTransaction = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.green)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Buscar transacciones...")
            .sheet(isPresented: $showingAddTransaction) {
                AddTransactionView(financeManager: financeManager)
            }
        }
    }
}
