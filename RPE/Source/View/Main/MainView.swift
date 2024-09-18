
import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MySBDViewModel
    
    @State private var workout = ""
    @State private var rpeValue = 0.0
    @State private var repsValue = 0.0
    @State private var selectRpe = 0
    @State private var selectReps = 0
    
    @State private var typeColor = Color.white
    @State private var textColor = Color.black
    
    private let rpeModel = RpeData()
    private let colorData = ColorPickers.TypeColorData()
    private let colorData2 = ColorPickers.TextColorData()
    
    //    init(viewModel: MySBDViewModel) {
    //        self.viewModel = viewModel
    //    }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray).opacity(0.3)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("RPE")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(textColor)
                }
                
                //                HStack {
                //                    Spacer()
                //
                //                    ColorPicker("", selection: $typeColor)
                //                        .onChange(of: typeColor) { newValue in
                //                            colorData.saveColor(color: typeColor)
                //                        }
                //                        .frame(width: 30)
                //
                //                    ColorPicker("", selection: $textColor)
                //                        .onChange(of: textColor) { newValue in
                //                            colorData2.saveColor(color: textColor)
                //                        }
                //                        .frame(width: 30)
                //                }
                
                HStack {
                    Picker("Choose a type", selection: $workout) {
                        ForEach(["Squat", "Benchpress", "Deadlift"], id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .background(typeColor)
                    .cornerRadius(20)
                    .padding(.vertical)
                }
                
                VStack {
                    HStack {
                        Text("RPE")
                            .bold()
                            .foregroundColor(textColor)
                            .frame(width: 50)
                        
                        Slider(value: $rpeValue, in: 6.5...10, step: 0.5, onEditingChanged: { editing in
                            if !editing {
                                /// 사용자가 슬라이더 조작을 마치면 selectRpe에 매핑된 값을 할당
                                selectRpe = Int((10 - rpeValue) / 0.5)
                            }
                        })
                        
                        Text("10")
                            .foregroundColor(textColor)
                    }
                    HStack {
                        if rpeValue != 0.0 {
                            Text("Selected Rpe : \(rpeValue, specifier: rpeValue.truncatingRemainder(dividingBy: 1) == 0 ? "%.0f" : "%.1f")")
                                .foregroundColor(.gray)
                        } else {
                            Text("Selected Rpe")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.leading, 5)
                }
                .padding()
                .background(typeColor)
                .cornerRadius(20)
                
                VStack {
                    HStack {
                        Text("REPS")
                            .bold()
                            .foregroundColor(textColor)
                            .frame(width: 50)
                        
                        Slider(value: $repsValue, in: 1...12, step: 1, onEditingChanged: { editing in
                            if !editing {
                                selectReps = Int(repsValue-1)
                            }
                        })
                        
                        Text("12")
                            .foregroundColor(textColor)
                    }
                    
                    HStack {
                        if repsValue != 0.0 {
                            Text("Selected Reps : \(repsValue, specifier: "%.0f")")
                                .foregroundColor(.gray)
                        } else {
                            Text("Selected Reps")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.leading, 5)
                }
                .padding()
                .background(typeColor)
                .cornerRadius(20)
                .padding(.bottom)
                
                VStack {
                    Text(getWeightLabel())
                        .font(.system(size: 54, weight: .bold))
                        .foregroundColor(textColor)
                    
                    Text("\(workout) \(repsValue != 0.0 ? "x \(Int(repsValue))" : "") \(rpeValue != 0.0 ? "@" : "") \(rpeValue != 0.0 ? (rpeValue.isWhole ? String(format: "%.0f", rpeValue) : String(format: "%.1f", rpeValue)) : "")")
                        .padding(.top, 20)
                        .foregroundColor(textColor)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(typeColor)
                .cornerRadius(20)
            }
            .padding()
//            .onAppear(perform: {
//                typeColor = colorData.loadColor()
//                textColor = colorData2.loadColor()
//            })
        }
        .onAppear {
            viewModel.loadData()   // 뷰가 나타날 때마다 데이터를 새로 고침
        }
    }
    
    /// 사용자가 입력한 종목에 따라 중량, RPE, REPS를 계산하여 표시함
    func getWeightLabel() -> String {
        
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
}

extension Double {
    // getWeightLabel() 에서 무게가 정수형으로 떨어지면 소수점은 표기 안함
    var isWhole: Bool {
        return floor(self) == self
    }
}

#Preview {
    MainView(viewModel: MySBDViewModel())
}
