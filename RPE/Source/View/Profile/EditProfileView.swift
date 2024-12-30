//
//  EditProfileView.swift
//  RPE
//
//  Created by 이상도 on 12/30/24.
//

import SwiftUI

struct EditProfileView: View {
    
    @State private var nickName = "Eninem"
    @State private var isSelectedGender = "MALE"
    @State private var bodyWeight: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                // HeaderView
                HStack {
                    Image(systemName: "xmark")
                        .frame(width: 17, height: 17)
                        .foregroundStyle(.white)
                        .bold()
                    Spacer()
                    Text("Edit Profile")
                        .font(.setPretendard(weight: .semiBold, size: 17))
                        .foregroundStyle(.white)
                    Spacer()
                    Text("완료")
                        .font(.setPretendard(weight: .regular, size: 15))
                        .foregroundStyle(.white)
                }
                .padding(.bottom)
                
                ScrollView {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 98, height: 98)
                    
                    VStack(spacing: 16) {
                        // Nickname
                        VStack(spacing: 10) {
                            HStack {
                                Text("Nickname")
                                    .font(.setPretendard(weight: .semiBold, size: 14))
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            HStack {
                                TextField("Squat Weight", text: $nickName)
                                    .multilineTextAlignment(.leading)
                                    .frame(height: 44)
                                    .padding(.horizontal)
                                    .background(.white)
                                    .cornerRadius(12)
                                    .keyboardType(.decimalPad)
                                //                                .onChange(of: nickName) { oldValue, newValue in
                                //                                    nickName = String(newValue.prefix(18))
                                //                                }
                            }
                            HStack {
                                // 닉네임은 18자 이하로 입력해주세요.
                                Text("Names need to be less than 18 characters long.")
                                    .font(.setPretendard(weight: .medium, size: 12))
                                    .foregroundStyle(.red)
                                    .opacity(nickName.count > 18 ? 1 : 0) // ⚠️ 이게 Visible 상태면 닉네임 저장 안되게 해야함 ! 18자 이하일때만 닉네임 변경되게.
                                Spacer()
                            }
                        }
                        
                        // Gender
                        VStack(spacing: 10) {
                            HStack {
                                Text("Gender")
                                    .font(.setPretendard(weight: .semiBold, size: 14))
                                    .foregroundStyle(.white)
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
                        
                        // Body Weight
                        VStack(spacing: 10) {
                            HStack {
                                Text("Bodyweight")
                                    .font(.setPretendard(weight: .semiBold, size: 14))
                                    .foregroundStyle(.white)
                                Spacer()
                            }
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
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top)
                }
                
                Spacer()
            }
            .padding(.horizontal) // 제일 바깥 padding
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .applyGradientBackground()
    }
}

#Preview {
    EditProfileView()
}
