import Foundation
import SwiftUI

enum Btn : String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case add = "+"
    case subtract = "-"
    case multiply = "×"
    case divide = "÷"
    case equals = "="
    case clear = "C"
    case decimal = "."
    case plusMinus = "±"
    case percent = "%"
    
    var btnColor : Color {
        switch self {
        case .clear :
            return Color.redColor
        case .equals :
            return Color.greenColor
        default :
            return Color.mainBtnColor
        }
    }
    
    var bgBtnColor : Color {
        switch self {
        case .percent, .divide, .multiply, .subtract, .add :
            return Color.greenColor
        case .equals, .clear:
            return Color.darkColor
        default :
            return Color(.white)
        }
    }
}

enum Operation {
    case add, sub, mult, div, none
}



