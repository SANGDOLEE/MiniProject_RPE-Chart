
import SwiftUI
import RealmSwift

struct MainView: View {
    
    @StateObject var viewModel: BigThreeViewModel
    
    @State private var workout = ""
    @State private var rpeValue = 0.0
    @State private var repsValue = 0.0
    @State private var selectRpe = 0
    @State private var selectReps = 0
    
    @State private var profile: Profile? // Profile 데이터를 저장할 변수
    
    private let rpeModel = Rpe()
    
    //    init(viewModel: MySBDViewModel) {
    //        self.viewModel = viewModel
    //    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("RPE Chart")
                    .font(.setPretendard(weight: .bold, size: 34))
                    .foregroundStyle(.white)
                Spacer()
            }
            
            HStack {
                Picker("Choose a type", selection: $workout) {
                    ForEach(["Squat", "BenchPress", "Deadlift"], id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .background(.myBackBoxcolor.opacity(0.5))
                .cornerRadius(12)
                .padding(.vertical)
            }
            
            VStack {
                HStack {
                    Text("RPE  ")
                        .font(.setPretendard(weight: .semiBold, size:  18))
                        .foregroundStyle(.white)
                        .frame(width: 56)
                    
                    if rpeValue != 0.0 {
                        Text("\(rpeValue, specifier: rpeValue.truncatingRemainder(dividingBy: 1) == 0 ? "%.0f" : "%.1f")")
                            .foregroundStyle(.myAccentcolor)
                            .font(.setPretendard(weight: .semiBold, size: 18))
                    }
                    Spacer()
                }
                HStack(spacing: 16) {
                    Slider(value: $rpeValue, in: 6.5...10, step: 0.5, onEditingChanged: { editing in
                        if !editing {
                            /// 사용자가 슬라이더 조작을 마치면 selectRpe에 매핑된 값을 할당
                            selectRpe = Int((10 - rpeValue) / 0.5)
                        }
                    })
                    .tint(.myAccentcolor)
                    .onChange(of: rpeValue) { oldValue, newValue in
                        triggerHaptic()
                    }
                    
                    Text("10")
                        .font(.setPretendard(weight: .semiBold, size: 17))
                        .foregroundStyle(.myEBEBF5)
                }
                .padding(.horizontal)
            }
            .padding()
            .background(.myBackBoxcolor.opacity(0.5))
            .cornerRadius(12)
            
            VStack {
                HStack {
                    Text("REPS")
                        .font(.setPretendard(weight: .semiBold, size:  18))
                        .foregroundStyle(.white)
                        .frame(width: 56)
                    
                    if repsValue != 0.0 {
                        Text("\(repsValue, specifier: "%.0f")")
                            .foregroundStyle(.myAccentcolor)
                            .font(.setPretendard(weight: .semiBold, size: 18))
                    }
                    Spacer()
                }
                HStack(spacing: 16) {
                    Slider(value: $repsValue, in: 1...12, step: 1, onEditingChanged: { editing in
                        if !editing {
                            selectReps = Int(repsValue-1)
                        }
                    })
                    .tint(.myAccentcolor)
                    .onChange(of: repsValue) { oldValue, newValue in
                        triggerHaptic()
                    }
                    
                    Text("12")
                        .font(.setPretendard(weight: .semiBold, size: 17))
                        .foregroundStyle(.myEBEBF5)
                }
                .padding(.horizontal)
                
            }
            .padding()
            .background(.myBackBoxcolor.opacity(0.5))
            .cornerRadius(12)
            .padding(.vertical)
            
            VStack(spacing: 4) {
                HStack {
                    Spacer()
                    
                    if !workout.isEmpty {
                        Text(workout.uppercased())
                            .font(.setPretendard(weight: .medium, size: 14))
                            .foregroundStyle(.myA09393)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(.my858585.opacity(0.13))
                            .cornerRadius(24)
                    }
                    
                    if repsValue != 0.0 {
                        Text("x \(Int(repsValue))")
                            .font(.setPretendard(weight: .medium, size: 14))
                            .foregroundStyle(.myA09393)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(.my858585.opacity(0.13))
                            .cornerRadius(24)
                    }
                    
                    if rpeValue != 0.0 {
                        Text("@ \(rpeValue.isWhole ? String(format: "%.0f", rpeValue) : String(format: "%.1f", rpeValue))")
                            .font(.setPretendard(weight: .medium, size: 14))
                            .foregroundStyle(.myA09393)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(.my858585.opacity(0.13))
                            .cornerRadius(24)
                    }
                }
                .frame(height: 40)
                .padding(.trailing)
                
                HStack {
                    Text(getWeightLabel())
                        .font(.setPretendard(weight: .bold, size: getWeightLabel() ==  "Fill out your BigThree\nin Setting" ? 26 : 52))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(getWeightLabel() ==  "Fill out your BigThree\nin Setting" ? .myA09393 : .myAccentcolor)
                }
                .padding(.bottom)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 136)
            .background(.myBackBoxcolor.opacity(0.5))
            .cornerRadius(12)
            
            Spacer()
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .applyGradientBackground()
        .onAppear {
            loadProfileData()
            viewModel.loadData()   // 뷰가 나타날 때마다 데이터를 새로 고침
        }
    }
    
    // 사용자가 입력한 종목에 따라 중량, RPE, REPS를 계산하여 표시함
    func getWeightLabel() -> String {
        
        print("Selected workout: \(workout)")
        print("selectRpe: \(selectRpe), selectReps: \(selectReps)")
        
        // EnterView에서 Weight 데이터가 입력되어있지 않다면 "Weight" 기본 표기
        guard !viewModel.squatValue.isEmpty, !viewModel.benchValue.isEmpty, !viewModel.deadValue.isEmpty else {
            return "Fill out your BigThree\nin Setting"
        }
        
        // 사용자가 설정하는 Reps와 Rpe에 따라서 해당 값의 해당 하는 데이터를 곱하여 계산하여 보여준다.
        switch workout {
        case "Squat":
            if let squatValue = Double(viewModel.squatValue) {
                let calculatedValue = squatValue * rpeModel.rpeArray[selectRpe][selectReps]
                return calculatedValue.isWhole ? String(Int(calculatedValue)) : String(format: "%.1f", calculatedValue)
            } else {
                return "Invalid squat value"
            }
            
        case "BenchPress":
            if let benchValue = Double(viewModel.benchValue) {
                let calculatedValue = benchValue * rpeModel.rpeArray[selectRpe][selectReps]
                return calculatedValue.isWhole ? String(Int(calculatedValue)) : String(format: "%.1f", calculatedValue)
            } else {
                return "Invalid bench value"
            }
            
        case "Deadlift":
            if let deadValue = Double(viewModel.deadValue) {
                let calculatedValue = deadValue * rpeModel.rpeArray[selectRpe][selectReps]
                return calculatedValue.isWhole ? String(Int(calculatedValue)) : String(format: "%.1f", calculatedValue)
            } else {
                return "Invalid deadlift value"
            }
        default:
            return ""
        }
    }
    
    // 테스트용 프린트문
    private func loadProfileData() {
        let realm = try! Realm()
        if let profileData = realm.objects(Profile.self).first {
            profile = profileData
            print("Nickname: \(profileData.nickname ?? "N/A")")
            print("Gender: \(profileData.gender)")
            print("BodyWeight: \(profileData.bodyWeight)")
        } else {
            print("No profile data found.")
        }
    }
    
    // 햅틱
    private func triggerHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
}

extension Double {
    var isWhole: Bool {
        // getWeightLabel() 에서 무게가 정수형으로 떨어지면 소수점은 표기 안함
        return floor(self) == self
    }
}

#Preview {
    MainView(viewModel: BigThreeViewModel())
}
