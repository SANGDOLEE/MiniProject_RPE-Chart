import SwiftUI

@main
struct RPEApp: App {
    @State private var isEnterViewPresented = true
    
    @AppStorage("isFirstRun") private var isFirstRun = true
    
    var body: some Scene {
        WindowGroup {
            
            if isFirstRun {
                EnterView(isPresented: $isFirstRun)
            } else {
                ContentView()
            }
            
        }
    }
}
