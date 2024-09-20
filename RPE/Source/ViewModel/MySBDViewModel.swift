
import SwiftUI

class MySBDViewModel: ObservableObject {
    
    @Published var squatValue: String = ""
    @Published var benchValue: String = ""
    @Published var deadValue: String = ""

    init() {
        squatValue = UserDefaults.standard.string(forKey: "squatValue") ?? ""
        benchValue = UserDefaults.standard.string(forKey: "benchValue") ?? ""
        deadValue = UserDefaults.standard.string(forKey: "deadValue") ?? ""
    }

    func saveData() {
        UserDefaults.standard.setValue(squatValue, forKey: "squatValue")
        UserDefaults.standard.setValue(benchValue, forKey: "benchValue")
        UserDefaults.standard.setValue(deadValue, forKey: "deadValue")
    }
    
    func loadData() {
           // UserDefaults에서 데이터를 로드하는 로직
           let defaults = UserDefaults.standard
           squatValue = defaults.string(forKey: "squatValue") ?? ""
           benchValue = defaults.string(forKey: "benchValue") ?? ""
           deadValue = defaults.string(forKey: "deadValue") ?? ""
           
           // 데이터가 로드되었음을 알림
           objectWillChange.send()
    }
}
