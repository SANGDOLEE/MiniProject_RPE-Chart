import SwiftUI

// MARK: - 2개의 탭이 있는 메인뷰
struct MainView: View {
    
    @ObservedObject var viewModel: MySBDViewModel
    @StateObject private var isItextViewModel = IsTextViewModel()
    
    @State private var workout = ""
    
    @State private var rpeValue = 0.0
    @State private var repsValue = 0.0
    
    @State private var showAlert = false
    
    /// 사용자가 슬라이더에서 사용한 값을 RpeDataModel에서 배열 위치 값으로 사용 할 변수
    @State private var selectRpe = 0
    @State private var selectReps = 0
    
    /// 단위 변환 변수 ( kg <-> lbs )
    @State private var isText : Bool = false
    
    let rpeModel = RpeData() // RpeData 객체 생성
    
    /// Color Picker
    @State private var typeColor = Color.blue
    private var colorData = ColorPickers.TypeColorData()
    @State private var textColor = Color.black
    private var colorData2 = ColorPickers.TextColorData()
    @State private var bgColor = Color.white
    
    /// 2번째 탭 - Setting시 Modal로 가는 변수
    @State var isModalSheetShown:Bool = false
    
    public init(viewModel: MySBDViewModel) {
            self.viewModel = viewModel
            // 다른 프로퍼티들의 초기화가 필요하다면 여기에 추가
            _isItextViewModel = StateObject(wrappedValue: IsTextViewModel())
            // ... 다른 프로퍼티 초기화 ...
        }
    
    var body: some View {
       
            // MARK: - Frist Tab ( RPE Chart )
            VStack {
                HStack {
                    
                    Text("What's")
                        .bold()
                        .scaleEffect(1.5)
                        .padding()
                        .foregroundColor(textColor)
                    
                   
                }
                HStack {
                    ColorPicker("", selection: $typeColor)
                        .onChange(of: typeColor) { newValue in
                            colorData.saveColor(color: typeColor)
                        }
                        .background(.yellow)
                    
                    ColorPicker("", selection: $textColor)
                        .onChange(of: textColor) { newValue in
                            colorData2.saveColor(color: textColor)
                        }
                        .background(.yellow)
                }
                
                Picker("Choose a type", selection: $workout) {
                    ForEach(["Squat", "Benchpress", "Deadlift"], id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .background(typeColor)
                .cornerRadius(20)
                .padding()
                
                VStack {
                    HStack {
                        Text("RPE     ")
                            .foregroundColor(textColor)
                        Slider(value: $rpeValue, in: 6.5...10, step: 0.5, onEditingChanged: { editing in
                            if !editing {
                                /// 사용자가 슬라이더 조작을 마치면 selectRpe에 매핑된 값을 할당
                                selectRpe = Int((10 - rpeValue) / 0.5)
                            }
                        })
                        Text("10")
                            .foregroundColor(textColor)
                    }
                    .padding(10)
                    
                    if rpeValue != 0.0 {
                        Text("Rpe : \(rpeValue, specifier: rpeValue.truncatingRemainder(dividingBy: 1) == 0 ? "%.0f" : "%.1f")") /// 정수로 떨어지면 소수점 표기 안함
                            .foregroundColor(textColor)
                    } else {
                        Text("") /// 슬라이더 안건드렸다면
                            .foregroundColor(textColor)
                    }
                }
                
                VStack {
                    HStack {
                        Text("REPS")
                            .foregroundColor(textColor)
                        Slider(value: $repsValue, in: 1...12, step: 1, onEditingChanged: { editing in
                            if !editing {
                                /// 사용자가 슬라이더 조작을 마치면 selectReps에 선택된 값을 할당
                                selectReps = Int(repsValue-1)
                            }
                        })
                        .padding()
                        
                        Text("12")
                            .foregroundColor(textColor)
                    }
                    .padding(10)
                    
                    if repsValue != 0.0 {
                        Text("Reps : \(repsValue, specifier: "%.0f")")
                            .foregroundColor(textColor)
                    } else {
                        Text("")
                            .foregroundColor(textColor)
                    }
                }
                
                Spacer()
                
                Text(getWeightLabel())
                    .scaleEffect(4.0)
                    .bold()
                    .foregroundColor(textColor)
                
                Text("\(workout.isEmpty ? "" : String(workout.prefix(1))) \(repsValue != 0.0 ? "x \(Int(repsValue))" : "") \(rpeValue != 0.0 ? "@" : "") \(rpeValue != 0.0 ? (rpeValue.isWhole ? String(format: "%.0f", rpeValue) : String(format: "%.1f", rpeValue)) : "")")
                    .padding(.top, 20)
                    .foregroundColor(textColor)
                
                Spacer()
            }
            .onAppear(perform: {
                typeColor = colorData.loadColor()
                textColor = colorData2.loadColor()
            })
            .padding()
            
        
    }
    
    // MARK: - 사용자가 입력한 종목에 따라 중량, RPE, REPS를 계산하여 표시함
    func getWeightLabel() -> String {
        
        // 테스트용 출력
        print("Selected workout: \(workout)")
        print("selectRpe: \(selectRpe), selectReps: \(selectReps)")
        
        // EnterView에서 Weight 데이터가 입력되어있지 않다면 "Weight" 기본 표기
        guard !viewModel.squatValue.isEmpty, !viewModel.benchValue.isEmpty, !viewModel.deadValue.isEmpty else {
            return "Weight"
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
            
        case "Benchpress":
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
    
    // total 무게 포맷
     func formatTotalValue(_ totalValue: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        formatter.groupingSeparator = ""
        formatter.usesGroupingSeparator = false
        
        return formatter.string(from: NSNumber(value: totalValue)) ?? "\(totalValue)"
    }
}


// getWeightLabel() 에서 무게가 정수형으로 떨어지면 소수점은 표기 안함
extension Double {
    var isWhole: Bool {
        return floor(self) == self
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

//#Preview {
//    MainView()
//}
