import SwiftUI

@main
struct RPEApp: App {
    
    @AppStorage("isFirstRun") private var isFirstRun = true
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    @Environment(\.colorScheme) var systemColorScheme
    
    var body: some Scene {
        WindowGroup {
            if isFirstRun {
                OnboardingView(isPresented: $isFirstRun)
            } else {
                MainTabView()
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
