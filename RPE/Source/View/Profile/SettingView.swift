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
    
    @State private var showEditProfile = false // EditProfileSheet
    @State private var showUpdateRecord = false
    @State private var showUnitofMesaure = false
    
    var body: some View {
        ZStack {
            VStack {
                // HeaderView
                ZStack {
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
                    }
                    HStack {
                        Text("Settings")
                            .font(.setPretendard(weight: .semiBold, size: 17))
                            .foregroundStyle(.white)
                    }
                }
                .padding(.bottom)
                
                VStack(spacing: 26) {
                    
                    MyInformationView()
                    
                    ConfigurationView()
                }
                
                Spacer()
            }
            .padding(.horizontal) // 제일 바깥 padding
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .applyGradientBackground()
        .onAppear {
            isMainTabbarVisible = false
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(showEditProfile: showEditProfile)
        }
        .fullScreenCover(isPresented: $showUpdateRecord) {
            UpdateRecordView(isMainTabbarVisible: $isMainTabbarVisible, showUpdateRecord: showUpdateRecord)
        }
        .fullScreenCover(isPresented: $showUnitofMesaure) {
            WeightUnitView(isMainTabbarVisible: $isMainTabbarVisible, showUnitofMesaure: showUnitofMesaure)
        }
    }
    
    // MARK: MY INFORMATION View
    private func MyInformationView() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("My Information")
                .font(.setPretendard(weight: .semiBold, size: 14))
                .foregroundStyle(.myB9B9B9)
                .padding(.bottom, 8)
            
            // "Edit Profile" 버튼
            Button {
                showEditProfile = true // fullScreenCover 띄우기
            } label: {
                HStack {
                    Text("Edit Profile")
                        .font(.setPretendard(weight: .regular, size: 16))
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color(hex: "555556"))
                }
                .padding()
                .background(.myBackBoxcolor)
                .cornerRadius(8)
            }
            
            // "My BigThree" 버튼
            Button {
                showUpdateRecord = true // fullScreenCover 띄우기
            } label: {
                HStack {
                    Text("Update BigThree Weight")
                        .font(.setPretendard(weight: .regular, size: 16))
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color(hex: "555556"))
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
            
            Button {
                showUnitofMesaure = true
            } label: {
                HStack {
                    Text("Unit of measure")
                        .font(.setPretendard(weight: .regular, size: 16))
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(Color(hex: "555556"))
                }
                .padding()
                .background(.myBackBoxcolor)
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
