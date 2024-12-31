//
//  EditProfileView.swift
//  RPE
//
//  Created by 이상도 on 12/30/24.
//

import SwiftUI
import RealmSwift

struct EditProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var userNickname = ""
    @State private var isSelectedGender = "Male"
    @State private var bodyWeight: String = ""
    
    @State var showEditProfile: Bool // EditProfileSheet
    
    var body: some View {
        ZStack {
            VStack {
                // HeaderView
                HStack {
                    Button {
                        dismiss()
                        showEditProfile = false
                    } label: {
                        Image(systemName: "xmark")
                            .frame(width: 17, height: 17)
                            .foregroundStyle(.white)
                            .bold()
                    }
                    Spacer()
                    Text("Edit Profile")
                        .font(.setPretendard(weight: .semiBold, size: 17))
                        .foregroundStyle(.white)
                    Spacer()
                    Button {
                        setUserNickname()
                        
                        dismiss()
                        showEditProfile = false
                    } label: {
                        Text("완료")
                            .font(.setPretendard(weight: .regular, size: 15))
                            .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal) // 바깥 padding 16
                
                Divider()
                    .frame(height: 1) // 두께를 조정
                    .background(.myB9B9B9.opacity(0.3))
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
                                ZStack {
                                    TextField("", text: $userNickname)
                                        .multilineTextAlignment(.leading)
                                        .frame(height: 44)
                                        .padding(.horizontal)
                                        .background(.white)
                                        .cornerRadius(12)
                                    //                                .onChange(of: nickName) { oldValue, newValue in
                                    //                                    nickName = String(newValue.prefix(18))
                                    //                                }
                                    HStack {
                                        Spacer()
                                        XmarkButton(text: $userNickname)
                                    }
                                }
                            }
                            HStack {
                                // 닉네임은 18자 이하로 입력해주세요.
                                Text("Names need to be less than 18 characters long.")
                                    .font(.setPretendard(weight: .medium, size: 12))
                                    .foregroundStyle(.red)
                                    .opacity(userNickname.count > 18 ? 1 : 0) // ⚠️ 이게 Visible 상태면 닉네임 저장 안되게 해야함 ! 18자 이하일때만 닉네임 변경되게.
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
                .padding(.horizontal) // 바깥 padding 16
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .applyGradientBackground()
        .onAppear {
            loadUserNickname() // View가 나타날 때 닉네임 로드
        }
        .onTapGesture {
            UIApplication.shared.closeKeyboard()
        }
    }
    
    private func loadUserNickname() {
        let realm = try! Realm()
        
        if let profile = realm.objects(Profile.self).first {
            userNickname = profile.nickname ?? ""
        }
    }
    
    private func setUserNickname() {
        let realm = try! Realm()
        
        // 기본적으로 존재하는 Profile 객체를 검색
        if let existingProfile = realm.objects(Profile.self).first {
            // Profile이 이미 존재하면 닉네임을 업데이트
            try! realm.write {
                existingProfile.nickname = userNickname
            }
            print("Nickname updated: \(userNickname)")
        } else {
            // Profile이 없으면 새로 생성
            let newProfile = Profile(
                nickname: userNickname,
                image: nil, // 이미지 저장 로직이 별도로 필요
                gender: isSelectedGender,
                bodyWeight: Double(bodyWeight) ?? 0.0
            )
            
            try! realm.write {
                realm.add(newProfile)
            }
            print("New profile created with nickname: \(userNickname)")
        }
    }
}

#Preview {
    EditProfileView(showEditProfile: true)
}
