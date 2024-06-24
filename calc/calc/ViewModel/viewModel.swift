import Foundation
import SwiftUI

class ViewModel: ObservableObject{
    
    @Published var display = "0"
    @Published var num : Double = 0
    @Published var curOperation : Operation = .none
    @Published var currentInput: String = ""
    @Published var isEqualsPressed: Bool = false
    @Published var intermediateResult: Double = 0
    @Published var errorMessage: String? = nil
    
    let btnArray: [[Btn]] = [
        [.clear, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equals]
    ]
    
    func btnWidth(item : Btn) -> CGFloat {
        let space : CGFloat = 12
        let totalSpace : CGFloat = 5 * space
        let equalsTotalSpace : CGFloat = 4 * space
        let totalColum : CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        
        if item == Btn.equals{
            return (screenWidth - equalsTotalSpace) / totalColum * 2
        }
        
        return (screenWidth - totalSpace) / totalColum
    }
    
    func btnHeight() -> CGFloat {
        let space : CGFloat = 12
        let totalSpace : CGFloat = 5 * space
        let totalColum : CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        
        return (screenWidth - totalSpace) / totalColum
    }
    
    func btnTap(item: Btn) {
        errorMessage = nil

        switch item {
        case .add, .subtract, .multiply, .divide:
            if currentInput.isEmpty {
                display = display.dropLast(3) + " \(item.rawValue) "
                curOperation = item.btnToOperat()
            } else if let currValue = Double(currentInput) {
                if curOperation != .none {
                    num = performOper(currValue)
                    intermediateResult = num
                } else {
                    num = currValue
                    intermediateResult = num
                }
                curOperation = item.btnToOperat()
                currentInput = ""
                display += " \(item.rawValue) "
                isEqualsPressed = false
            }
        case .equals:
            if let currValue = Double(currentInput) {
                let result = performOper(currValue)
                if errorMessage == nil {
                    display = formResult(result)
                } else {
                    display = errorMessage!
                }
                curOperation = .none
                currentInput = display
                isEqualsPressed = true
            }
        case .clear:
            display = "0"
            num = 0
            curOperation = .none
            currentInput = ""
            isEqualsPressed = false
            intermediateResult = 0
        case .decimal:
            if !currentInput.contains(".") {
                currentInput += "."
                display += "."
            }
        case .plusMinus:
            if let currValue = Double(currentInput) {
                let newValue = -currValue
                currentInput = formResult(newValue)
                display = display.replacingOccurrences(of: formResult(currValue), with: formResult(newValue))
            }
        case .percent:
            if let currValue = Double(currentInput) {
                let newValue = currValue / 100
                currentInput = formResult(newValue)
                display = display.replacingOccurrences(of: formResult(currValue), with: formResult(newValue))
            }
        default:
            if currentInput.count < 8 {
                if currentInput == "0" {
                    currentInput = item.rawValue
                } else {
                    currentInput += item.rawValue
                }
                if display == "0" {
                    display = item.rawValue
                } else {
                    display += item.rawValue
                }

                if let currValue = Double(currentInput) {
                    intermediateResult = performOper(currValue)
                }
            }
        }
    }

    
    //method
        func performOper(_ curValue: Double) -> Double {
            switch curOperation {
            case .add:
                return num + curValue
            case .sub:
                return num - curValue
            case .mult:
                return num * curValue
            case .div:
                if curValue == 0 {
                    errorMessage = "Не определено"
                    return num
                } else {
                    return num / curValue
                }
            default:
                return curValue
            }
        }
    
    func formResult(_ result: Double) -> String{
        return String(format: "%g", result)
    }
}
