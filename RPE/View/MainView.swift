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

// ColorPicker 1
class TypeColorData {
    private let COLOR_KEY = "TYPECOLOR"
    private let userDefaults = UserDefaults.standard
    
    func saveColor(color: Color) {
        let color = UIColor(color).cgColor
        
        if let components = color.components {
            userDefaults.set(components, forKey: COLOR_KEY)
        }
    }
    
    func loadColor() -> Color {
        guard let colorComponents = userDefaults.object(forKey: COLOR_KEY) as? [CGFloat] else {
            return Color.blue // 처음 기본색은 BLUE
        }
        
        let color = Color(.sRGB,
                          red: colorComponents[0],
                          green: colorComponents[1],
                          blue: colorComponents[2],
                          opacity: colorComponents[3]
        )
        return color
    }
}
// ColorPicker 2
class TextColorData {
    private let COLOR_KEY = "TEXTCOLOR"
    private let userDefaults = UserDefaults.standard
    
    func saveColor(color: Color) {
        let color = UIColor(color).cgColor
        
        if let components = color.components {
            userDefaults.set(components, forKey: COLOR_KEY)
        }
    }
    
    func loadColor() -> Color {
        guard let colorComponents = userDefaults.object(forKey: COLOR_KEY) as? [CGFloat] else {
            return Color.black // 처음 기본색은 Black
        }
        
        let color = Color(.sRGB,
                          red: colorComponents[0],
                          green: colorComponents[1],
                          blue: colorComponents[2],
                          opacity: colorComponents[3]
        )
        return color
        
    }
}
struct MainView: View {
    
    @StateObject private var viewModel = MySBDViewModel()
    @StateObject private var isItextViewModel = IsTextViewModel()
    
    @State private var workout = ""
    
    @State private var rpeValue = 0.0
    @State private var repsValue = 0.0
    
    @State private var showAlert = false
    
    // 사용자가 슬라이더에서 사용한 값을 RpeDataModel에서 배열 위치 값으로 사용 할 변수
    @State private var selectRpe = 0
    @State private var selectReps = 0
    
    // 단위 변환 변수 ( kg <-> lbs )
    @State private var isText : Bool = false
    
    let rpeModel = RpeDataModel() // RpeDataModel 객체 생성
    
    // Color Picker
    @State private var typeColor = Color.blue
    private var colorData = TypeColorData()
    @State private var textColor = Color.black
    private var colorData2 = TextColorData()
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
                            .onChange(of: typeColor) { newValue in
                                colorData.saveColor(color: typeColor)
                            }
                    }
                    HStack() {
                        ColorPicker("", selection: $textColor)
                            .onChange(of: textColor) { newValue in
                                colorData2.saveColor(color: textColor)
                            }
                        
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
                            let formattedTotal = formatTotalValue(totalValue)
                            Text(formattedTotal)
                                .font(.system(size: 24))
                                .bold()
                                .foregroundColor(Color.blue)
                        }
                        
                        Text("\(isText ? "lb" : "kg")")
                            .font(.system(size:24))
                        
                    }
                    Spacer().frame(height: 40)
                    
                    HStack {
                        Text("SQ")
                            .font(.system(size: 24))
                            .fontWeight(.light)
                        TextField("Enter weight", text: $viewModel.squatValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .fontWeight(.thin)
                            .multilineTextAlignment(.center)
                            .frame(width: 115)
                            .onChange(of: viewModel.squatValue) { newValue in
                                viewModel.squatValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                            }
                        Text("\(isText ? "lb" : "kg")")
                    }
                    
                    HStack {
                        Text("BP")
                            .font(.system(size: 24))
                            .fontWeight(.light)
                        TextField("Enter weight", text: $viewModel.benchValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 115)
                            .fontWeight(.thin)
                            .onChange(of: viewModel.benchValue) { newValue in
                                viewModel.benchValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                            }
                        Text("\(isText ? "lb" : "kg")")
                    }
                    
                    HStack {
                        Text("DL")
                            .font(.system(size: 24))
                            .fontWeight(.light)
                        TextField("Enter weight", text: $viewModel.deadValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 115)
                            .fontWeight(.thin)
                            .onChange(of: viewModel.deadValue) { newValue in
                                viewModel.deadValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                            }
                        Text("\(isText ? "lb" : "kg")")
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
                        Alert( // 사용자가 3가지중 1가지라도 공백으로 둘 시 Alert
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
                        SettingView(showModal: $isModalSheetShown,isText:$isText)
                    }
                )
                
            }
            .onAppear {
                // 중량 표시 단위 kg/lb 중 사용자가 마지막에 설정한것으로 띄워준다.
                isText = UserDefaults.standard.bool(forKey: "isText")
            }
            .onTapGesture {
                hideKeyboard()
            }
            .tabItem {
                Text("My SBD")
            }
        }
    }
    
    // 사용자가 입력한 종목에 따라서 입력 중량 , RPE, REPS를 계산하여 표시해줌
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
    
    // total 무게 포맷
    private func formatTotalValue(_ totalValue: Double) -> String {
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
