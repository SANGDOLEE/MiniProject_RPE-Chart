//
//  MyRecordView.swift
//  RPE
//
//  Created by 이상도 on 9/17/24.
//

import SwiftUI

struct MyRecordView: View {
    
    @StateObject private var viewModel = MySBDViewModel()
    @State private var isText : Bool = false
    
    @State private var showAlert = false
    @State var isModalSheetShown:Bool = false
    
    var body: some View {
        
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
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.blue)
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
                Spacer()
                    .frame(height: 40)
                
                HStack {
                    Text("SQ")
                        .font(.system(size: 24, weight: .light))
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
                        .font(.system(size: 24, weight: .light))
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
                        .font(.system(size: 24, weight: .light))
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
            }
            .onTapGesture {
                UIApplication.shared.windows.first?.endEditing(true)
            }
            .padding()
            
            // MARK: - Navigation 영역
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
    }
    
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

#Preview {
    MyRecordView()
}
