import Foundation

// Model for Transaction
struct Transaction: Identifiable {
    let id = UUID()
    let companyName: String
    let transactionDate: String
    let transactionStatus: String
    let transactionAmount: String
    let transactionNumber: String
}



 let exampleTransactions1 = [
    Transaction(companyName: "OOO “Company”", transactionDate: "01.06.2024", transactionStatus: "Executed", transactionAmount: "$10.09", transactionNumber: "1"),
    Transaction(companyName: "OOO “Company2”", transactionDate: "02.06.2024", transactionStatus: "Declined", transactionAmount: "$10.09", transactionNumber: "2"),
    Transaction(companyName: "OOO “Company3”", transactionDate: "03.06.2024", transactionStatus: "Executed", transactionAmount: "$10.09", transactionNumber: "3"),
    Transaction(companyName: "OOO “Company2”", transactionDate: "04.06.2024", transactionStatus: "Declined", transactionAmount: "$10.09", transactionNumber: "4"),
    Transaction(companyName: "OOO “Company2”", transactionDate: "05.06.2024", transactionStatus: "Declined", transactionAmount: "$10.09", transactionNumber: "5"),
    Transaction(companyName: "OOO “Company”", transactionDate: "06.06.2024", transactionStatus: "In progress", transactionAmount: "$10.09", transactionNumber: "6"),
    Transaction(companyName: "OOO “Company”", transactionDate: "07.06.2024", transactionStatus: "In progress", transactionAmount: "$10.09", transactionNumber: "7"),
]

 let exampleTransactions2 = [
    Transaction(companyName: "OOO “Company”", transactionDate: "01.07.2024", transactionStatus: "Executed", transactionAmount: "$15.25", transactionNumber: "101"),
    Transaction(companyName: "OOO “Company2”", transactionDate: "03.07.2024", transactionStatus: "Declined", transactionAmount: "$20.49", transactionNumber: "102"),
    Transaction(companyName: "OOO “Company3”", transactionDate: "05.07.2024", transactionStatus: "Executed", transactionAmount: "$35.10", transactionNumber: "103"),
    Transaction(companyName: "OOO “Company2”", transactionDate: "07.07.2024", transactionStatus: "Declined", transactionAmount: "$12.89", transactionNumber: "104"),
    Transaction(companyName: "OOO “Company2”", transactionDate: "09.07.2024", transactionStatus: "Declined", transactionAmount: "$8.50", transactionNumber: "105"),
    Transaction(companyName: "OOO “Company”", transactionDate: "11.07.2024", transactionStatus: "In progress", transactionAmount: "$18.75", transactionNumber: "106"),
    Transaction(companyName: "OOO “Company”", transactionDate: "13.07.2024", transactionStatus: "In progress", transactionAmount: "$22.30", transactionNumber: "107"),
]

 let exampleTransactions3 = [
    Transaction(companyName: "AO “Company4”", transactionDate: "02.08.2024", transactionStatus: "Executed", transactionAmount: "$55.00", transactionNumber: "201"),
    Transaction(companyName: "AO “Company5”", transactionDate: "04.08.2024", transactionStatus: "Declined", transactionAmount: "$32.75", transactionNumber: "202"),
    Transaction(companyName: "AO “Company6”", transactionDate: "06.08.2024", transactionStatus: "Executed", transactionAmount: "$28.99", transactionNumber: "203"),
    Transaction(companyName: "AO “Company5”", transactionDate: "08.08.2024", transactionStatus: "Declined", transactionAmount: "$40.60", transactionNumber: "204"),
    Transaction(companyName: "AO “Company5”", transactionDate: "10.08.2024", transactionStatus: "Declined", transactionAmount: "$12.99", transactionNumber: "205"),
    Transaction(companyName: "AO “Company4”", transactionDate: "12.08.2024", transactionStatus: "In progress", transactionAmount: "$75.20", transactionNumber: "206"),
    Transaction(companyName: "AO “Company4”", transactionDate: "14.08.2024", transactionStatus: "In progress", transactionAmount: "$65.45", transactionNumber: "207"),
]


