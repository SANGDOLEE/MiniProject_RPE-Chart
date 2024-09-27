import SwiftUI

@main
struct RPEApp: App {
    @AppStorage("isFirstRun") private var isFirstRun = true
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    @Environment(\.colorScheme) var systemColorScheme
    
    var body: some Scene {
        WindowGroup {
            if isFirstRun {
                FirstInputView(isPresented: $isFirstRun)
            } else {
                TabViewManagement()
                    .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
                    .onAppear {
                        updateUserInterfaceStyle()
                    }
            }
        }
    }
    
    private func updateUserInterfaceStyle() {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.windows.first?.overrideUserInterfaceStyle = isDarkModeEnabled ? .dark : .light
            }
        }
    }
}
