//
//  UpdateRecordView.swift
//  RPE
//
//  Created by 이상도 on 9/18/24.
//

import SwiftUI

struct UpdateRecordView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var viewModel: MySBDViewModel
    @AppStorage("isText") private var isText: Bool = false
    
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            Color.mainBackground
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Text("Congratulations!\nBe careful of your injuries.")
                        .padding(.leading, 30)
                        .font(.Pretendard.Regular.size18)
                        .foregroundColor(Color(hex: "9D9DA3"))
                    
                    Spacer()
                }
                
                VStack {
                    HStack {
                        Text("TOTAL")
                            .font(.Pretendard.SemiBold.size24)
                            .foregroundStyle(Color.font)
                        
                        let squatValue = Double(viewModel.squatValue) ?? 0.0
                        let benchValue = Double(viewModel.benchValue) ?? 0.0
                        let deadValue = Double(viewModel.deadValue) ?? 0.0
                        
                        let totalValue = squatValue + benchValue + deadValue
                        if totalValue.truncatingRemainder(dividingBy: 1) == 0 {
                            Text("\(Int(totalValue))")
                                .font(.Pretendard.Bold.size24)
                                .foregroundColor(.blue)
                        } else {
                            let formattedTotal = formatTotalValue(totalValue)
                            Text(formattedTotal)
                                .font(.Pretendard.Bold.size24)
                                .foregroundColor(.blue)
                        }
                        Text(isText ? "lb" : "kg")
                            .font(.Pretendard.Bold.size24)
                            .font(.system(size: 24))
                            .foregroundStyle(Color.font)
                    }
                    .padding(.top)
                    
                    HStack {
                        Text("SQ")
                            .font(.Pretendard.Medium.size24)
                            .foregroundStyle(Color.font)
                        TextField("Enter weight", text: $viewModel.squatValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .font(.Pretendard.Regular.size18)
                            .multilineTextAlignment(.center)
                            .frame(width: 115)
                            .onChange(of: viewModel.squatValue) { newValue in
                                viewModel.squatValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                            }
                        Text(isText ? "lb" : "kg")
                    }
                    
                    HStack {
                        Text("BP")
                            .font(.Pretendard.Medium.size24)
                            .foregroundStyle(Color.font)
                        TextField("Enter weight", text: $viewModel.benchValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 115)
                            .font(.Pretendard.Regular.size18)
                            .onChange(of: viewModel.benchValue) { newValue in
                                viewModel.benchValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                            }
                        Text(isText ? "lb" : "kg")
                    }
                    
                    HStack {
                        Text("DL")
                            .font(.Pretendard.Medium.size24)
                            .foregroundStyle(Color.font)
                        TextField("Enter weight", text: $viewModel.deadValue)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 115)
                            .font(.Pretendard.Regular.size18)
                            .onChange(of: viewModel.deadValue) { newValue in
                                viewModel.deadValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                            }
                        Text(isText ? "lb" : "kg")
                    }
                    
                    HStack {
                        Button(action: {
                            totalUpdate()
                        }) {
                            Text("UPDATE")
                                .font(.Pretendard.Bold.size24)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .cornerRadius(20)
                        }
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Message"),
                            message: Text("Please enter weight values for all types."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .padding(.bottom)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(Color.stackBackground)
                .cornerRadius(20)
                .padding()
                
                Spacer()
            }
            .onTapGesture {
                UIApplication.shared.windows.first?.endEditing(true)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    private func totalUpdate() {
        if viewModel.squatValue.isEmpty || viewModel.benchValue.isEmpty || viewModel.deadValue.isEmpty {
            showAlert = true
        } else {
            viewModel.saveData()
            UIApplication.shared.windows.first?.endEditing(true)
        }
    }
    
    // Custom navigation back button
    var backButton : some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left") // 화살표 Image
                    .aspectRatio(contentMode: .fit)
                    .bold()
            }
        }
    }
}

extension UpdateRecordView {
    
    private func formatTotalValue(_ totalValue: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        formatter.groupingSeparator = ""
        formatter.usesGroupingSeparator = false
        
        return formatter.string(from: NSNumber(value: totalValue)) ?? "\(totalValue)"
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    UpdateRecordView(viewModel: MySBDViewModel())
}
