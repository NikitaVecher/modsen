import Foundation

// Model for CreditCard
struct CreditCard: Identifiable {
    let id = UUID()
    var accountDescription: String
    var accountNumber: String
    var maskedCardNumber: String
    var transactions: [Transaction]
}

var exampleCreditCards = [
   CreditCard(accountDescription: "My first account", accountNumber: "91212192291221", maskedCardNumber: "•••• 1234", transactions: exampleTransactions1),
   CreditCard(accountDescription: "For travelling", accountNumber: "91212192291221", maskedCardNumber: "•••• 5678", transactions: exampleTransactions2),
   CreditCard(accountDescription: "Saving Account", accountNumber: "91212192291221", maskedCardNumber: "•••• 9101", transactions: exampleTransactions3)
]
