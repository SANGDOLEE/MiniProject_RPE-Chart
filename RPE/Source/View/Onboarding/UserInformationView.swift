//
//  UserInformationView.swift
//  RPE
//
//  Created by 이상도 on 12/29/24.
//


import SwiftUI

// MARK: - 앱의 첫 사용시에만 등장하는 뷰
struct UserInformationView: View {
    
    @Environment(NavigationRouter.self) var navigationRouter
    @AppStorage("isFirstRun") private var isFirstRun: Bool?
    @StateObject private var viewModel = BigThreeViewModel()
    
    @State private var showAlert = false
    
    @State private var isSelectedGender = "MALE"
    
    @State private var bodyWeight: String = ""
    
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    navigationRouter.pop()
                } label: {
                    Image(systemName: "chevron.left")
                        .frame(width: 24, height: 24)
                        .tint(.white)
                }
                Spacer()
                Button {
                    isFirstRun = false
                } label: {
                    Text("SKIP")
                        .font(.setPretendard(weight: .semiBold, size: 18))
                        .foregroundStyle(.white)
                }
            }
            
            VStack(alignment: .center, spacing: 10) {
                Text("Fill Out Your Information")
                    .font(.setPretendard(weight: .semiBold, size: 26))
                    .foregroundStyle(.white)
                Text("For an instant\ncalculation of your Points")
                    .font(.setPretendard(weight: .medium, size: 18))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 40)
            
            VStack(spacing: 22) {
                VStack {
                    HStack {
                        Text("Gender")
                            .font(.setPretendard(weight: .bold, size: 18))
                            .foregroundStyle(.myAccentcolor)
                        Spacer()
                    }
                    HStack(spacing: 16) {
                        Button {
                            isSelectedGender = "MALE"
                        } label: {
                            Text("MALE")
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .font(.setPretendard(weight: isSelectedGender == "MALE" ? .bold : .regular, size: 16))
                                .foregroundStyle(isSelectedGender == "MALE" ? .black : .white)
                                .background(isSelectedGender == "MALE" ? .myAccentcolor : .myB9B9B9)
                                .cornerRadius(12)
                        }
                        
                        Button {
                            isSelectedGender = "FEMALE"
                        } label: {
                            Text("FEMALE")
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .font(.setPretendard(weight: isSelectedGender == "FEMALE" ? .bold : .regular, size: 16))
                                .foregroundStyle(isSelectedGender == "FEMALE" ? .black : .white)
                                .background(isSelectedGender == "FEMALE" ? .myAccentcolor : .myB9B9B9)
                                .cornerRadius(12)
                        }
                    }
                }
                
                VStack {
                    HStack(spacing: 2) {
                        Text("BodyWeight(kgs)")
                            .font(.setPretendard(weight: .bold, size: 18))
                            .foregroundStyle(.myAccentcolor)
                        Spacer()
                    }
                    HStack {
                        ZStack {
                            TextField("BodyWeight", text: $bodyWeight)
                                .multilineTextAlignment(.leading)
                                .frame(height: 44)
                                .padding(.horizontal)
                                .background(.white)
                                .cornerRadius(12)
                                .keyboardType(.decimalPad)
                                .onChange(of: bodyWeight) { oldValue, newValue in
                                    bodyWeight = newValue.prefix(5).filter { "0123456789.".contains($0) }
                                }
                            HStack {
                                Spacer()
                                XmarkButton(text: $bodyWeight)
                            }
                        }
                        Spacer()
                    }
                }
                Spacer()
                
                Button {
                    /// 3개 중 1개라도 값이 비어있다면 데이터 저장되지 않음
                    if bodyWeight.count == 0 {
                        showAlert = true
                    } else {
                        viewModel.saveData()
                        UIApplication.shared.closeKeyboard()
                        isFirstRun = false
                    }
                } label: {
                    Text("COMPLETE")
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .font(.setPretendard(weight: .bold, size: 18))
                        .foregroundStyle(bodyWeight.count > 0 ? .black : .white)
                        .background(bodyWeight.count > 0 ? .myAccentcolor : .myB9B9B9)
                        .cornerRadius(12)
                }
                .padding(.top, 20)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Message"),
                        message: Text("Please enter Bodyweight."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .padding(.top, 36)
        }
        .padding()
        .applyGradientBackground()
        
        //        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onTapGesture {
            UIApplication.shared.closeKeyboard()
        }
    }
}

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

#Preview {
    UserInformationView()
        .environment(NavigationRouter())
}