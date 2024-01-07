import SwiftUI

@main
struct RPEApp: App {
    
    @State private var isEnterViewPresented = true
    
    @AppStorage("isFirstRun") private var isFirstRun = true
    
    var body: some Scene {
        WindowGroup {
            
            // 사용자의 기기에서 맨 처음 실행할때만 EnterView가 먼저 뜨고 이후엔 MainView가 첫화면
            
            if isFirstRun {
                EnterView(isPresented: $isFirstRun)
            } else {
                MainView()
            }
            
        }
    }
}
