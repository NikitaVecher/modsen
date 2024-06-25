import SwiftUI
import Foundation


extension Color {
    static let redColor = Color("redColor")
    static let greenColor = Color("greenColor")
    static let mainBtnColor = Color("mainBtnColor")
    static let darkColor = Color("darkColor")
}

extension Btn {
    func btnToOperat() -> Operation {
        switch self{
        case .add:
            return .add
        case .subtract:
            return .sub
        case .divide:
            return .div
        case .multiply:
            return .mult
        default:
            return .none
        }
        
    }
}
