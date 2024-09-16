import SwiftUI

// MARK: - Setting화면에서 중량단위 kg <-> lb 변경
class IsTextViewModel: ObservableObject {
    
    @Published var isText: Bool // kg <-> lb
    
    init() {
        self.isText = UserDefaults.standard.bool(forKey: "isText")
    }
    
    func saveData() {
        UserDefaults.standard.setValue(self.isText, forKey: "isText")
    }
}
