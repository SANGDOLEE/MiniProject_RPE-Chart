//
//  UpdateRecordView.swift
//  RPE
//
//  Created by 이상도 on 9/18/24.
//

import SwiftUI

struct UpdateRecordView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = BigThreeViewModel()
    @AppStorage("isText") private var unitOfWeight: Bool = false
    
    @State private var showAlert = false
    @Binding var isMainTabbarVisible: Bool
    
    @State var showUpdateRecord: Bool // EditProfileSheet
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // HeaderView
                HStack {
                    Spacer()
                    Text("Update Record")
                        .font(.setPretendard(weight: .semiBold, size: 17))
                        .foregroundStyle(.white)
                    Spacer()
//                    Button {
////                        setUserNickname()
////                        setUserGender()
////                        setUserBodyweight()
////                        setUserImage()    // 이미지 저장 로직
////                        
////                        dismiss()
////                        showEditProfile = false
//                    } label: {
//                        Text("완료")
//                            .font(.setPretendard(weight: .regular, size: 15))
//                            .foregroundStyle(.white)
//                    }
                    Button {
                        dismiss()
                        showUpdateRecord = false
                    } label: {
                        Image(systemName: "xmark")
                            .frame(width: 17, height: 17)
                            .foregroundStyle(.white)
                            .bold()
                    }
                }
                .padding(.horizontal) // 바깥 padding 16
                
                Divider()
                    .frame(height: 1) // 두께를 조정
                    .background(.myB9B9B9.opacity(0.3))
                    .padding(.bottom)
                    .padding(.top, 10)
                
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
                            Text(unitOfWeight ? "lb" : "kg")
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
                                    .foregroundStyle(.myA09393)
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
                                            viewModel.squatValue = newValue.prefix(6).filter { "0123456789.".contains($0) }
                                        }
                                    
                                    HStack {
                                        Spacer()
                                        XmarkButton(text: $viewModel.squatValue)
                                    }
                                }
                                UnitOfWeightView()
                            }
                        }
                        .padding(.top, 20)
                        
                        VStack {
                            HStack {
                                Text("BenchPress")
                                    .font(.setPretendard(weight: .bold, size: 18))
                                    .foregroundStyle(.myA09393)
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
                                            viewModel.benchValue = newValue.prefix(6).filter { "0123456789.".contains($0) }
                                        }
                                    
                                    HStack {
                                        Spacer()
                                        XmarkButton(text: $viewModel.benchValue)
                                    }
                                }
                                UnitOfWeightView()
                            }
                        }
                        
                        VStack {
                            HStack {
                                Text("Deadlift")
                                    .font(.setPretendard(weight: .bold, size: 18))
                                    .foregroundStyle(.myA09393)
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
                                            viewModel.deadValue = newValue.prefix(6).filter { "0123456789.".contains($0) }
                                        }
                                    
                                    HStack {
                                        Spacer()
                                        XmarkButton(text: $viewModel.deadValue)
                                    }
                                }
                                UnitOfWeightView()
                            }
                        }
                        
                        HStack {
                            AccentButton {
                                totalUpdate()
                            } label: {
                                Text("UPDATE")
                            }
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
        .applyGradientBackground()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onAppear {
            isMainTabbarVisible = false
        }
        .onTapGesture {
            UIApplication.shared.closeKeyboard()
        }
    }
    
    @ViewBuilder
    private func UnitOfWeightView() -> some View {
        Text(unitOfWeight ? "lb" : "kg")
            .font(.setPretendard(weight: .bold, size: 18))
            .foregroundStyle(.white)
            .padding([.trailing, .top])
    }
    
    private func totalUpdate() {
        if viewModel.squatValue.isEmpty || viewModel.benchValue.isEmpty || viewModel.deadValue.isEmpty {
            showAlert = true
        } else {
            viewModel.saveData()
            UIApplication.shared.closeKeyboard()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                Toast.shared.present(
                    text: "Record update completed",
                    symbol: "complete",
                    isUserInteractionEnabled: true,
                    timing: .short
                )
            }
        }
    }
    
    var backButton : some View {
        Button{
            dismiss()
            isMainTabbarVisible = true
        } label: {
            HStack {
                Image(systemName: "chevron.left") // 화살표 Image
                    .frame(width: 24, height: 24)
                    .tint(.white)
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
    RootView {
        UpdateRecordView(isMainTabbarVisible: .constant(true), showUpdateRecord: true)
    }
}

