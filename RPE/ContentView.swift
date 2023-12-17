import SwiftUI


class MySBDViewModel: ObservableObject {
    
    @Published var squatValue = ""
    @Published var benchValue = ""
    @Published var deadValue = ""
    
    init() {
        // 앱 시작 시 UserDefaults에서 값을 불러옴 ( 값 계속 사용 )
        squatValue = UserDefaults.standard.string(forKey: "squatValue") ?? ""
        benchValue = UserDefaults.standard.string(forKey: "benchValue") ?? ""
        deadValue = UserDefaults.standard.string(forKey: "deadValue") ?? ""
    }
    
    func saveData() {
        // 데이터 저장로직 추가
        UserDefaults.standard.setValue(squatValue, forKey: "squatValue")
        UserDefaults.standard.setValue(benchValue, forKey: "benchValue")
        UserDefaults.standard.setValue(deadValue, forKey: "deadValue")
    }
}

struct ContentView: View {
    
    @StateObject private var viewModel = MySBDViewModel()
    
    @State private var workout = ""
    
    @State private var rpeValue = 0.0
    @State private var repsValue = 0.0
    
    @State private var showAlert = false
    
    // 사용자가 슬라이더에서 사용한 값을 RpeDataModel에서 배열 위치 값으로 사용 할 변수
    @State private var selectRpe = 0
    @State private var selectReps = 0
    
    // 단위 변환으로 사용할 변수 ( 키로그램 , 파운드 )
    @State private var kgValue = "kg"
    @State private var lbsValue = "lbs"
    
    let rpeModel = RpeDataModel() // RpeDatModel 객체 생성
    
    // Color Picker
    @State private var typeColor = Color.blue
    @State private var textColor = Color.black
    @State private var bgColor = Color.white
    
    // 2번째 탭 - Setting시 Modal로 가는 변수
    @State var isModalSheetShown:Bool = false
    
    var body: some View {
        TabView {
            VStack {
                ZStack() {
                    
                    HStack() {
                        ColorPicker("", selection: $typeColor).padding(30)
                        Spacer()
                        
                    }
                    HStack() {
                        ColorPicker("", selection: $textColor)
                        
                    }
                    HStack() {
                        Text("What's")
                            .bold()
                            .scaleEffect(1.5)
                            .padding()
                            .foregroundColor(textColor)
                        
                    }
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
                                // 사용자가 슬라이더 조작을 마치면 selectRpe에 매핑된 값을 할당
                                selectRpe = Int((10 - rpeValue) / 0.5)
                            }
                        })
                        
                        Text("10")
                            .foregroundColor(textColor)
                    }
                    .padding(10)
                    
                    if rpeValue != 0.0 {
                        Text("Rpe : \(rpeValue, specifier: rpeValue.truncatingRemainder(dividingBy: 1) == 0 ? "%.0f" : "%.1f")") // 정수로 떨어지면 소수점 표기 안함
                            .foregroundColor(textColor)
                    } else {
                        Text("") // 슬라이더 안건드렸다면
                            .foregroundColor(textColor)
                    }
                }
                VStack {
                    HStack {
                        Text("REPS")
                            .foregroundColor(textColor)
                        Slider(value: $repsValue, in: 1...12, step: 1, onEditingChanged: { editing in
                            if !editing {
                                // 사용자가 슬라이더 조작을 마치면 selectReps에 선택된 값을 할당
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
                
                Text("\(workout.isEmpty ? "" : workout) \(repsValue != 0.0 ? "x \(Int(repsValue))" : "") \(rpeValue != 0.0 ? "@" : "") \(rpeValue != 0.0 ? String(format: "%.1f", rpeValue) : "")")
                    .padding(.top, 20)
                    .foregroundColor(textColor)
                
                Spacer()
            }
            .padding()
            .tabItem {
                Text("RPE Chart")
            }
            
            
            
            // Second Tab
            NavigationView{
                VStack {
                    Spacer()
                    
                    HStack {
                        Text("total")
                            .font(.system(size:27))
                        let squatValue = Double(viewModel.squatValue) ?? 0.0
                        let benchValue = Double(viewModel.benchValue) ?? 0.0
                        let deadValue = Double(viewModel.deadValue) ?? 0.0
                        
                        let totalValue = squatValue + benchValue + deadValue
                        if totalValue.truncatingRemainder(dividingBy: 1) == 0 {
                            // 정수형일 경우
                            Text("\(Int(totalValue))")
                                .font(.system(size: 24))
                                .bold()
                                .foregroundColor(Color.blue)
                        } else {
                            // 소수점 1자리까지 표시
                            Text("\(String(format: "%.1f", totalValue))")
                                .font(.system(size: 24))
                                .bold()
                                .foregroundColor(Color.blue)
                        }
                        
                        Text("\(kgValue)")
                            .font(.system(size:24))
                    }
                    Spacer().frame(height: 40)
                    
                    HStack {
                        Text("SQ")
                        //.bold()
                            .font(.system(size: 24))
                        TextField("Enter Weight", text: $viewModel.squatValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 115)
                            .onChange(of: viewModel.squatValue) { newValue in
                                viewModel.squatValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                            }
                        Text("\(kgValue)")
                    }
                    
                    HStack {
                        Text("BP")
                        //.bold()
                            .font(.system(size: 24))
                        TextField("Enter Weight", text: $viewModel.benchValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 115)
                            .onChange(of: viewModel.benchValue) { newValue in
                                viewModel.benchValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                            }
                        Text("\(kgValue)")
                    }
                    
                    HStack {
                        Text("DL")
                        //.bold()
                            .font(.system(size: 24))
                        TextField("Enter Weight", text: $viewModel.deadValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 115)
                            .onChange(of: viewModel.deadValue) { newValue in
                                viewModel.deadValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                            }
                        Text("\(kgValue)")
                    }
                    Spacer().frame(height: 40) // 간격을 두기 위한 Spacer
                    
                    HStack {
                        Button("UPDATE") {
                            // 3개중 1개라도 값이 비어있다면 데이터 저장되지 않음
                            if viewModel.squatValue.isEmpty || viewModel.benchValue.isEmpty || viewModel.deadValue.isEmpty {
                                showAlert = true
                            } else {
                                viewModel.saveData()
                                UIApplication.shared.windows.first?.endEditing(true)
                            }
                        }
                        .buttonStyle(InsetRoundScaleButton(labelColor: .white, backgroundColor: .blue))
                        .bold()
                        .font(.system(size: 24))
                        
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Message"),
                            message: Text("Please enter weight values for all types."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    Spacer()
                }.onTapGesture {
                    UIApplication.shared.windows.first?.endEditing(true)
                }
                .padding()
                
                
                
                /// Navigation 영역
                .navigationBarTitle("Setting Weight", displayMode: .inline) // Set navigation title here
                
                
                .navigationBarItems(trailing:
                                        Button(action: {
                    isModalSheetShown.toggle()
                }) {
                    Image(systemName: "gear")
                        .foregroundColor(.black)
                }
                    .sheet(isPresented: $isModalSheetShown) {
                        settingView(showModal: $isModalSheetShown)
                    }
                )
                
                
            }
            .onTapGesture {
                hideKeyboard()
            }
            .tabItem {
                Text("My SBD")
            }
        }
    }
    
    
    // 사용자가 입력한 종목에 따라서 입력 중량 , RPE, REPS를 계산하여 표시하여줌
    func getWeightLabel() -> String {
        
        // 오류 확인 디버깅용 출력 메세지
        /*
         print("Selected workout: \(workout)")
         print("selectRpe: \(selectRpe), selectReps: \(selectReps)")
         */
        
        // Weight 데이터가 입력되어있지 않다면 "Weight" 기본 표기
        guard !viewModel.squatValue.isEmpty, !viewModel.benchValue.isEmpty, !viewModel.deadValue.isEmpty else {
            return "Weight"
        }
        
        // Reps와 Rpe에 따라서 해당 값의 해당 하는 데이터를 곱하여 계산하여 보여준다.
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
    
    struct InsetRoundScaleButton: ButtonStyle {
        var labelColor = Color.white
        var backgroundColor = Color.blue
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding(.horizontal, 19)
                .padding(.vertical, 5)
                .foregroundColor(labelColor)
                .background(Capsule().fill(backgroundColor))
                .scaleEffect(configuration.isPressed ? 0.88 : 1.0)
        }
    }
    
}


// getWeightLabel() 에서 무게가 정수형으로 떨어지면 소수점은 표기 X
extension Double {
    var isWhole: Bool {
        return floor(self) == self
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
