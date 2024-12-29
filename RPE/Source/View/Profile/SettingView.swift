//
//  SettingView.swift
//  RPE
//
//  Created by 이상도 on 12/30/24.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isText") private var unitOfWeight: Bool = false
    @Binding var isMainTabbarVisible: Bool
    
    var body: some View {
        ZStack {
            VStack {
                // HeaderView
                HStack {
                    Button {
                        dismiss()
                        isMainTabbarVisible = true
                    } label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 24, height: 24)
                            .tint(.white)
                    }
                    Spacer()
                    Text("Settings")
                        .font(.setPretendard(weight: .semiBold, size: 17))
                        .foregroundStyle(.white)
                        .padding(.trailing, 16)
                    Spacer()
                }
                .padding(.bottom)
                
                VStack(spacing: 26) {
                    
                    MyInformationView()
                    
                    ConfigurationView()
                }
                Spacer()
                
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .applyGradientBackground()
        .onAppear {
            isMainTabbarVisible = false
        }
    }
    
    // MARK: MY INFORMATION View
    private func MyInformationView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Information")
                .font(.setPretendard(weight: .semiBold, size: 14))
                .foregroundStyle(.myB9B9B9)
                .padding(.bottom, 8)
            
            // "My BigThree" 버튼
            NavigationLink(destination: UpdateRecordView(viewModel: BigThreeViewModel(),isMainTabbarVisible: $isMainTabbarVisible)) {
                HStack {
                    Text("My BigThree")
                        .font(.setPretendard(weight: .regular, size: 16))
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color(hex: "555556")) //  ⚠️ 나중에 색깔 변경 고려
                }
                .padding()
                .background(.myBackBoxcolor)
                .cornerRadius(8)
            }
        }
    }
    
    // MARK: - CONFIGURATION View
    private func ConfigurationView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("User settings")
                .font(.setPretendard(weight: .semiBold, size: 14))
                .foregroundStyle(.myB9B9B9)
                .padding(.bottom, 8)
            
            // "Weight Unit Conversion" 버튼
            NavigationLink(destination: WeightUnitView(isMainTabbarVisible: $isMainTabbarVisible)) {
                HStack {
                    Text("Weight Unit Conversion")
                        .font(.setPretendard(weight: .regular, size: 16))
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color(hex: "555556"))  //  ⚠️ 나중에 색깔 변경 고려
                }
                .padding()
                .background(Color.myBackBoxcolor)
                .cornerRadius(8)
            }
            
            //                    HStack {
            //                        Text("Display Mode")
            //                        Spacer()
            //                        Toggle("Auto Switch Mode", isOn: $isDarkModeEnabled)
            //                            .labelsHidden()
            //                            .onChange(of: isDarkModeEnabled) { value in
            //                                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            //                                    windowScene.windows.first?.overrideUserInterfaceStyle = value ? .dark : .light
            //                                }
            //                            }
            //                    }
        }
    }
}

#Preview {
    SettingView(isMainTabbarVisible: .constant(true))
}