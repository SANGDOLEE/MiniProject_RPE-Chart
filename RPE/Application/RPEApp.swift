import SwiftUI

@main
struct RPEApp: App {
    
    @AppStorage("isFirstRun") private var isFirstRun = true
    
    var body: some Scene {
        WindowGroup {
            if isFirstRun {
                FirstInputView(isPresented: $isFirstRun)
            } else {
                TabViewManagement()
            }
            
        }
    }
}
