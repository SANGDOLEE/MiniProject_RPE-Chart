import SwiftUI

class IsTextViewModel: ObservableObject {
    
    @Published var isText: Bool // kg <-> lb
    
    init() {
        self.isText = UserDefaults.standard.bool(forKey: "isText")
    }
    
    func saveData() {
        UserDefaults.standard.setValue(self.isText, forKey: "isText")
    }
}
