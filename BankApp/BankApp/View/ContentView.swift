import SwiftUI

struct ContentView: View {
    @State private var showTransactionAllView = false
    @State private var transactionLimit: Int? = 4
    @State private var selectedCardIndex: Int? = 0

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea(.all)
                VStack(spacing: 20) {
                    HStack {
                        Text("Account")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.leading, 16)
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    CreditCardView(selectedCardIndex: $selectedCardIndex)
                        .padding(.horizontal, 16)
                    
                    HStack {
                        Text("Recent Transactions")
                            .font(.system(size: 24))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.leading, 16)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.easeInOut) {
                                showTransactionAllView = true
                            }
                        }) {
                            Text("VIEW ALL")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                                .padding(.trailing, 16.0)
                        }
                    }
                    
                    if let limit = transactionLimit, let index = selectedCardIndex {
                        TransactionsView(transactionLimit: limit, transactions: exampleCreditCards[index].transactions)
                            .padding(.horizontal, 16)
                    } else {
                        TransactionsView(transactions: [])
                            .padding(.horizontal, 16)
                    }
                    
                    Spacer()
                }
                
                if showTransactionAllView {
                    TransactionAllView(showTransactionAllView: $showTransactionAllView, selectedCardIndex: $selectedCardIndex)
                        .transition(.move(edge: .trailing))
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CreditCardView: View {
    @State private var showSheet = false
    @Binding var selectedCardIndex: Int?
    private let creditCards = exampleCreditCards
    
    var body: some View {
        VStack {
            HStack {
                Image("creditCardFront")
                    .resizable()
                    .frame(width: 40, height: 25)
                    .cornerRadius(5)
                    .padding(.leading, 16)
                    .offset(y: -15)
                
                VStack(alignment: .leading, spacing: 4) {
                    if let index = selectedCardIndex {
                        Text(creditCards[index].accountDescription)
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        
                        Text(creditCards[index].accountNumber)
                            .foregroundColor(.white)
                            .opacity(0.6)
                            .font(.system(size: 14))
                        
                        Text(creditCards[index].maskedCardNumber)
                            .foregroundColor(.white)
                            .opacity(0.6)
                            .font(.system(size: 14))
                    } else {
                        Text("No card selected")
                            .foregroundColor(.white)
                            .opacity(0.6)
                            .font(.system(size: 14))
                    }
                }
                .padding(.leading, 8)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
                    .padding(.trailing, 16)
                    .opacity(0.8)
            }
            .padding(.vertical, 16)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(13)
            .onTapGesture {
                showSheet.toggle()
            }
            .sheet(isPresented: $showSheet, content: {
                CreditCardDetailView(selectedCardIndex: $selectedCardIndex, showSheet: $showSheet)
                    .presentationDetents([.height(500)])
                    .presentationDragIndicator(.visible)
            })
        }
    }
}

struct CreditCardDetailView: View {
    @State private var creditCards: [CreditCard] = exampleCreditCards
    @Binding var selectedCardIndex: Int?
    @Binding var showSheet: Bool
    @State private var tempSelectedCardIndex: Int? = nil
    @State private var showAlert: Bool = false
    @State private var indexToDelete: Int? = nil
    
    var body: some View {
        VStack() {
            HStack(alignment: .center) {
                Text("Select the account")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, 16)
                    .padding(.top, 33)
                
                Spacer()
//                
//                Text("Edit")
//                    .font(.callout)
//                    .foregroundColor(.white)
//                    .padding(.top, 33)
//                    .padding(.trailing, 16.0)
            }
            
            Spacer().frame(height: 32)
            
            ScrollView {
                ForEach(creditCards.indices, id: \.self) { index in
                    VStack(spacing: 16) {
                        HStack {
                            Image("creditCardFront")
                                .resizable()
                                .frame(width: 40, height: 25)
                                .cornerRadius(5)
                                .padding(.leading, 16)
                                .offset(y: -15)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(creditCards[index].accountDescription)
                                    .font(.system(size: 17))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                
                                Text(creditCards[index].accountNumber)
                                    .foregroundColor(.white)
                                    .opacity(0.6)
                                    .font(.system(size: 14))
                                
                                Text(creditCards[index].maskedCardNumber)
                                    .foregroundColor(.white)
                                    .opacity(0.6)
                                    .font(.system(size: 14))
                            }
                            .padding(.leading, 8)
                            
                            Spacer()
                            
//                            Button(action: {
//                                indexToDelete = index
//                                showAlert = true
//                            }) {
//                                Image(systemName: "trash")
//                                    .foregroundColor(.red)
//                                    .padding(.trailing, 16.0)
//                            }
                        }
                        .padding(.vertical, 16)
                        .background(tempSelectedCardIndex == index ? Color("TapCardColor") : Color.clear)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(13)
                        .onTapGesture {
                            tempSelectedCardIndex = index
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            
            Divider()
                .background(Color.white.opacity(0.3))
                .padding(.all, 16)
            
            Button(action: {
                if let index = tempSelectedCardIndex {
                    selectedCardIndex = index
                    showSheet = false
                }
            }) {
                Text("Submit")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("btnColor"))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
            }
            .padding(.bottom, 35.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            tempSelectedCardIndex = selectedCardIndex
        }
//        .alert(isPresented: $showAlert) {
//            Alert(
//                title: Text("Delete Card"),
//                message: Text("Are you sure you want to delete this card?"),
//                primaryButton: .destructive(Text("Delete")) {
//                    if let index = indexToDelete {
//                        creditCards.remove(at: index)
//                        
//                    }
//                    indexToDelete = nil
//                },
//                secondaryButton: .cancel {
//                    indexToDelete = nil
//                }
//            )
//        }
    }
}

struct TransactionDetailView: View {
    var transaction: Transaction
    @Binding var showDetailView: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Transaction")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, 16)
                    .padding(.top, 33)
                
                Spacer()
            }
            
            Spacer().frame(height: 32)
            
            HStack{
                
                VStack(alignment: .leading, spacing: 8){
                    Text("Transaction was applied in")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .padding(.bottom, 5.0)
                    
                    
                    Text(transaction.companyName)
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                    
                    
                    
                    Text("Transaction number")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .padding(.bottom, 5.0)
                        .padding(.top, 8.0)
                    
                    Text(transaction.transactionNumber)
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                    
                    Text("Date")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .padding(.bottom, 5.0)
                        .padding(.top, 8.0)
                    
                    Text(transaction.transactionDate)
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                    
                    Text("Transaction status")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .padding(.bottom, 5.0)
                        .padding(.top, 8.0)
                    
                    Text(transaction.transactionStatus)
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                    
                    Text("Amount")
                        .font(.system(size: 17))
                        .foregroundColor(.white)
                        .padding(.bottom, 5.0)
                        .padding(.top, 8.0)
                    
                    Text(transaction.transactionAmount)
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                .padding(.horizontal, 16)
                Spacer()
            }
            
            Spacer().frame(height: 32)
            
            Button(action: {
                showDetailView = false
            }) {
                Text("Okay")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("btnColor"))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
            }
            .padding(.bottom, 35.0)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct TransactionRowView: View {
    var transaction: Transaction
    @State private var showTransactionDetail = false
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(transaction.companyName)
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text(transaction.transactionDate)
                        .foregroundColor(.white)
                        .opacity(0.6)
                        .font(.system(size: 14))
                    
                    Text(transaction.transactionStatus)
                        .foregroundColor(statusColor(for: transaction.transactionStatus))
                        .font(.system(size: 14))
                }
                .padding(.leading, 16)
                
                Spacer()
                
                Text(transaction.transactionAmount)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .padding(.trailing, 8)
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
                    .padding(.trailing, 16)
                    .opacity(0.6)
            }
            .padding(.vertical, 16.0)
            .onTapGesture {
                showTransactionDetail.toggle()
            }
            
            Divider()
                .background(Color.white.opacity(0.3))
                .padding(.horizontal, 16)
        }
        .padding(.vertical, 0.0)
        .sheet(isPresented: $showTransactionDetail, content: {
            TransactionDetailView(transaction: transaction, showDetailView: $showTransactionDetail)
                .presentationDetents([.height(700)])
                .presentationDragIndicator(.visible)
        })
    }
    
    func statusColor(for status: String) -> Color {
        switch status {
        case "Executed":
            return .green
        case "Declined":
            return .red
        case "In progress":
            return .yellow
        default:
            return .white
        }
    }
}

struct TransactionsView: View {
    var transactionLimit: Int?
    var transactions: [Transaction]
    
    var sortedTransactions: [Transaction] {
        transactions.sorted { $0.transactionDate > $1.transactionDate }
    }

    var body: some View {
        VStack {
            if let limit = transactionLimit {
                ForEach(sortedTransactions.prefix(limit)) { transaction in
                    TransactionRowView(transaction: transaction)
                }
            } else {
                ForEach(sortedTransactions) { transaction in
                    TransactionRowView(transaction: transaction)
                }
            }
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(13)
    }
}

struct FilterSheetView: View {
    @Binding var isPresented: Bool
    @State private var startDateSelected = false
    @State private var endDateSelected = false
    @State private var submitButtonPressed = false
    @State private var showStartDatePicker = false
    @State private var showEndDatePicker = false
    @State private var startDate = Date()
    @State private var endDate = Date()

    var onSubmit: (Date, Date) -> Void

    var body: some View {
        VStack {
            HStack {
                Text("Filter by date")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.leading, 16)
                    .padding(.top, 33)

                Spacer()
            }

            Spacer().frame(height: 32)

            VStack(alignment: .leading, spacing: 8) {
                Text("Start date")
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .padding(.bottom, 5.0)

                HStack {
                    Text(startDateSelected ? "\(startDate, formatter: dateFormatter)" : "Select start date")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .opacity(startDateSelected ? 1.0 : 0.8)
                        .padding(.vertical, 14)
                        .padding(.leading, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: "calendar")
                        .foregroundColor(.white)
                        .padding(.trailing, 12)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(startDateSelected || !submitButtonPressed ? Color.white : Color.red, lineWidth: 1)
                )
                .onTapGesture {
                    showStartDatePicker = true
                }
                .sheet(isPresented: $showStartDatePicker) {
                    VStack {
                        DatePicker("Select start date", selection: $startDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .labelsHidden()
                            .padding()

                        Button("Done") {
                            startDateSelected = true
                            showStartDatePicker = false
                        }
                        .padding()
                    }
                }

                Text("End date")
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .padding(.bottom, 5.0)
                    .padding(.top, 8.0)

                HStack {
                    Text(endDateSelected ? "\(endDate, formatter: dateFormatter)" : "Select end date")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .opacity(endDateSelected ? 1.0 : 0.8)
                        .padding(.vertical, 14)
                        .padding(.leading, 12)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Image(systemName: "calendar")
                        .foregroundColor(.white)
                        .padding(.trailing, 12)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(endDateSelected || !submitButtonPressed ? Color.white : Color.red, lineWidth: 1)
                )
                .onTapGesture {
                    showEndDatePicker = true
                }
                .sheet(isPresented: $showEndDatePicker) {
                    VStack {
                        DatePicker("Select end date", selection: $endDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .labelsHidden()
                            .padding()

                        Button("Done") {
                            endDateSelected = true
                            showEndDatePicker = false
                        }
                        .padding()
                    }
                }

            }
            .padding(.horizontal, 16.0)

            Spacer().frame(height: 24)

            Divider()
                .background(Color.white.opacity(0.8))

            Spacer().frame(height: 20)

            Button(action: {
                submitButtonPressed = true
                if startDateSelected && endDateSelected {
                    onSubmit(startDate, endDate)
                    isPresented = false // Dismiss the sheet after submission
                }
            }) {
                Text("Submit")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("btnColor").opacity(startDateSelected && endDateSelected ? 1 : 0.57))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
            }
            .padding(.bottom, 35.0)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

struct TransactionAllView: View {
    @Binding var showTransactionAllView: Bool
    @Binding var selectedCardIndex: Int?
    @State private var transactionLimit: Int?
    @State private var showFilterSheet = false
    @State private var filteredTransactions: [Transaction] = []
    @State private var startDate = Date()
    @State private var endDate = Date()

    init(showTransactionAllView: Binding<Bool>, selectedCardIndex: Binding<Int?>) {
        self._showTransactionAllView = showTransactionAllView
        self._selectedCardIndex = selectedCardIndex
        self._filteredTransactions = State(initialValue: exampleCreditCards[selectedCardIndex.wrappedValue ?? 0].transactions)
    }

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(.trailing, 16)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showTransactionAllView = false
                            }
                        }

                    Spacer()

                    Text("All Transactions")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .font(.system(size: 17))

                    Spacer()

                    ZStack {
                        Circle()
                            .stroke(Color.white, lineWidth: 3)
                            .background(Circle().fill(Color.black))
                            .frame(width: 24, height: 24)
                            .onTapGesture {
                                showFilterSheet.toggle()
                            }

                        Image(systemName: "ellipsis")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17, height: 17)
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 16.0)

                ScrollView {
                    if let limit = transactionLimit {
                        TransactionsView(transactionLimit: limit, transactions: filteredTransactions)
                            .padding(.horizontal, 16)
                    } else {
                        TransactionsView(transactions: filteredTransactions)
                            .padding(.horizontal, 16)
                    }
                }
                .padding(.top)

                Spacer()
            }
        }
        .onChange(of: selectedCardIndex) { newIndex, _ in
            if let index = newIndex {
                filteredTransactions = exampleCreditCards[index].transactions
            }
        }
        .sheet(isPresented: $showFilterSheet) {
            FilterSheetView(isPresented: $showFilterSheet) { start, end in
                startDate = start
                endDate = end
                filteredTransactions = filterTransactions(startDate: start, endDate: end)
            }
            .presentationDetents([.height(400)])
            .presentationDragIndicator(.visible)
        }
    }

    private func filterTransactions(startDate: Date, endDate: Date) -> [Transaction] {
        // Filter transactions based on dates
        let transactions = exampleCreditCards[selectedCardIndex ?? 0].transactions
        return transactions.filter { transaction in
            if let transactionDate = DateFormatter.transactionDateFormatter.date(from: transaction.transactionDate),
               transactionDate >= startDate.startOfDay() && transactionDate <= endDate.endOfDay() {
                return true
            }
            return false
        }
    }
}


#Preview {
    ContentView()
}



