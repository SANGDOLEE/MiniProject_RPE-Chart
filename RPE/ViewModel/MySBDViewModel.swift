import SwiftUI

// MARK: - Squat, BenchPress, Deadlfit 사용자 입력 값 저장&호출
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
}
