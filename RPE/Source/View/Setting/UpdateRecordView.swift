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
            VStack(spacing: 0) {
                HStack {
                    Text("Congratulations !\nBe careful of injuries")
                        .padding(.leading, 30)
                        .font(.setPretendard(weight: .regular, size: 18))
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                
                VStack {
                    VStack(spacing: 14) {
                        HStack(spacing: 0) {
//                            Text("TOTAL")
//                                .font(.setPretendard(weight: .semiBold, size: 24))
//                                .foregroundStyle(.white)
                            
                            let squatValue = Double(viewModel.squatValue) ?? 0.0
                            let benchValue = Double(viewModel.benchValue) ?? 0.0
                            let deadValue = Double(viewModel.deadValue) ?? 0.0
                            
                            let totalValue = squatValue + benchValue + deadValue
                            if totalValue.truncatingRemainder(dividingBy: 1) == 0 {
                                Text("\(Int(totalValue))")
                                    .font(.setPretendard(weight: .bold, size: 24))
                                    .foregroundStyle(.white)
                            } else {
                                let formattedTotal = formatTotalValue(totalValue)
                                Text(formattedTotal)
                                    .font(.setPretendard(weight: .bold, size: 24))
                                    .foregroundStyle(.white)
                            }
                            Text(isText ? "lb" : "kg")
                                .font(.setPretendard(weight: .bold, size: 24))
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [
                                Color(hex: "FFD700"), // 밝은 골드
                                Color(hex: "FFA500")  // 주황빛 골드
                            ]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                        .cornerRadius(12)
                        
                        VStack {
                            HStack {
                                Text("Squat")
                                    .font(.setPretendard(weight: .bold, size: 18))
                                    .foregroundStyle(.myAccentcolor)
                                Spacer()
                            }
                            HStack {
                                ZStack {
                                    TextField("Enter Weight", text: $viewModel.squatValue)
                                        .font(.setPretendard(weight: .regular, size: 18))
                                        .multilineTextAlignment(.leading)
                                        .frame(height: 44)
                                        .padding(.horizontal)
                                        .background(.white)
                                        .cornerRadius(12)
                                        .keyboardType(.decimalPad)
                                        .onChange(of: viewModel.squatValue) { oldValue, newValue in
                                            viewModel.squatValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                                        }
                                    
                                    HStack {
                                        Spacer()
                                        Button {
                                            viewModel.squatValue = ""
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .resizable()
                                                .frame(width: 23, height: 23)
                                                .foregroundStyle(.myB9B9B9)
                                        }
                                        .opacity(viewModel.squatValue.count > 0 ? 1 : 0)
                                        .padding(.trailing)
                                    }
                                }
                                Text(isText ? "lb" : "kg")
                                    .font(.setPretendard(weight: .bold, size: 18))
                                    .foregroundStyle(.white)
                                    .padding(.trailing)
                            }
                        }
                        .padding(.top, 20)
                        
                        VStack {
                            HStack {
                                Text("BenchPress")
                                    .font(.setPretendard(weight: .bold, size: 18))
                                    .foregroundStyle(.myAccentcolor)
                                Spacer()
                            }
                            HStack {
                                ZStack {
                                    TextField("Enter Weight", text: $viewModel.benchValue)
                                        .font(.setPretendard(weight: .regular, size: 18))
                                        .multilineTextAlignment(.leading)
                                        .frame(height: 44)
                                        .padding(.horizontal)
                                        .background(.white)
                                        .cornerRadius(12)
                                        .keyboardType(.decimalPad)
                                        .onChange(of: viewModel.benchValue) { oldValue, newValue in
                                            viewModel.benchValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                                        }
                                    
                                    HStack {
                                        Spacer()
                                        Button {
                                            viewModel.benchValue = ""
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .resizable()
                                                .frame(width: 23, height: 23)
                                                .foregroundStyle(.myB9B9B9)
                                        }
                                        .opacity(viewModel.benchValue.count > 0 ? 1 : 0)
                                        .padding(.trailing)
                                    }
                                }
                                Text(isText ? "lb" : "kg")
                                    .font(.setPretendard(weight: .bold, size: 18))
                                    .foregroundStyle(.white)
                                    .padding(.trailing)
                            }
                        }
                        
                        VStack {
                            HStack {
                                Text("Deadlift")
                                    .font(.setPretendard(weight: .bold, size: 18))
                                    .foregroundStyle(.myAccentcolor)
                                Spacer()
                            }
                            HStack {
                                ZStack {
                                    TextField("Enter Weight", text: $viewModel.deadValue)
                                        .font(.setPretendard(weight: .regular, size: 18))
                                        .multilineTextAlignment(.leading)
                                        .frame(height: 44)
                                        .padding(.horizontal)
                                        .background(.white)
                                        .cornerRadius(12)
                                        .keyboardType(.decimalPad)
                                        .onChange(of: viewModel.deadValue) { oldValue, newValue in
                                            viewModel.deadValue = newValue.prefix(5).filter { "0123456789.".contains($0) }
                                        }
                                    
                                    HStack {
                                        Spacer()
                                        Button {
                                            viewModel.deadValue = ""
                                        } label: {
                                            Image(systemName: "xmark.circle.fill")
                                                .resizable()
                                                .frame(width: 23, height: 23)
                                                .foregroundStyle(.myB9B9B9)
                                        }
                                        .opacity(viewModel.deadValue.count > 0 ? 1 : 0)
                                        .padding(.trailing)
                                    }
                                }
                                Text(isText ? "lb" : "kg")
                                    .font(.setPretendard(weight: .bold, size: 18))
                                    .foregroundStyle(.white)
                                    .padding(.trailing)
                            }
                        }
                        
                        HStack {
                            Button {
                                totalUpdate()
                            } label: {
                                Text("UPDATE")
                                    .font(.setPretendard(weight: .bold, size: 18))
                                    .foregroundStyle(.black)
                                    .cornerRadius(12)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .background(.myAccentcolor)
                            .cornerRadius(12)
                            .padding(.top, 22)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Message"),
                                message: Text("Please enter weight values for all types."),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(.myBackBoxcolor.opacity(0.5))
                .cornerRadius(12)
                .padding()
                
                Spacer()
            }
        }
        .onTapGesture {
            UIApplication.shared.closeKeyboard()
        }
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    Gradient.Stop(color: Color.init(hex: "2F4753"), location: 0.1),
                    Gradient.Stop(color: Color.init(hex: "0B001F"), location: 0.4),
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    private func totalUpdate() {
        if viewModel.squatValue.isEmpty || viewModel.benchValue.isEmpty || viewModel.deadValue.isEmpty {
            showAlert = true
        } else {
            viewModel.saveData()
            UIApplication.shared.closeKeyboard()
        }
    }
    
    var backButton : some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left") // 화살표 Image
                    .tint(.white)
                    .aspectRatio(contentMode: .fit)
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
}

#Preview {
    UpdateRecordView(viewModel: MySBDViewModel())
}
