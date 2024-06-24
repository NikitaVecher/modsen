import SwiftUI

@main
struct calcApp: App {
    @StateObject var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            mainView()
                .preferredColorScheme(.dark)
                .environmentObject(viewModel)
        }
    }
}
