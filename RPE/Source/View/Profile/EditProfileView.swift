//
//  EditProfileView.swift
//  RPE
//
//  Created by 이상도 on 12/30/24.
//

import SwiftUI
import RealmSwift
import PhotosUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var userProfileImage: UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    
    @State private var userNickname = ""
    @State private var userGender = ""
    @State private var userBodyweight: String = ""
    @AppStorage("isText") private var unitOfWeight: Bool = false
    
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
                        setUserGender()
                        setUserBodyweight()
                        setUserImage()    // 이미지 저장 로직
                        
                        dismiss()
                        showEditProfile = false
                    } label: {
                        Text("완료")
                            .font(.setPretendard(weight: .regular, size: 15))
                            .foregroundStyle( .white)
                    }
                }
                .padding(.horizontal) // 바깥 padding 16
                
                Divider()
                    .frame(height: 1) // 두께를 조정
                    .background(.myB9B9B9.opacity(0.3))
                    .padding(.bottom)
                
                ScrollView {
                    PhotosPicker(selection: $photosPickerItem) {
                        if let uiImage = userProfileImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 98, height: 98)
                                .clipShape(.circle)
                        } else {
                            // userProfileImage가 없을 경우 대체 이미지
                            Image(systemName: "person.crop.circle.badge.plus")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .tint(.myB9B9B9)
                                .frame(width: 98, height: 98)
                        }
                    }
                    .onChange(of: photosPickerItem) { _, _ in
                        Task {
                            if let photosPickerItem,
                               let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                                if let image = UIImage(data: data) {
                                    userProfileImage = image
                                }
                            }
                            photosPickerItem = nil
                        }
                    }
                    
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
                                if userNickname.count > 18 {
                                    // 닉네임이 18자를 초과할 경우 안내 문구
                                    Text("Names need to be less than 18 characters long.")
                                        .font(.setPretendard(weight: .medium, size: 12))
                                        .foregroundStyle(.myBF2418)
                                        .opacity(1)
                                } else if userNickname.isEmpty {
                                    // 닉네임이 비어있을 경우 안내 문구
                                    Text("Please enter name")
                                        .font(.setPretendard(weight: .medium, size: 12))
                                        .foregroundStyle(.myBF2418)
                                        .opacity(1)
                                } else {
                                    // 문구를 숨기기
                                    Text("")
                                        .font(.setPretendard(weight: .medium, size: 12))
                                        .opacity(0)
                                }
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
                                    userGender = "Male"
                                } label: {
                                    Text("MALE")
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 44)
                                        .font(.setPretendard(weight: userGender == "Male" ? .bold : .regular, size: 16))
                                        .foregroundStyle(userGender == "Male" ? .black : .white)
                                        .background(userGender == "Male" ? .myAccentcolor : .myB9B9B9)
                                        .cornerRadius(12)
                                }
                                
                                Button {
                                    userGender = "Female"
                                } label: {
                                    Text("FEMALE")
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 44)
                                        .font(.setPretendard(weight: userGender == "Female" ? .bold : .regular, size: 16))
                                        .foregroundStyle(userGender == "Female" ? .black : .white)
                                        .background(userGender == "Female" ? .myAccentcolor : .myB9B9B9)
                                        .cornerRadius(12)
                                }
                            }
                        }
                        
                        // Body Weight
                        VStack(spacing: 10) {
                            HStack {
                                Text("Body weight \(unitOfWeight ? "(lb)" : "(kg)")")
                                    .font(.setPretendard(weight: .semiBold, size: 14))
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            ZStack {
                                TextField("Body weight", text: $userBodyweight)
                                    .multilineTextAlignment(.leading)
                                    .frame(height: 44)
                                    .padding(.horizontal)
                                    .background(.white)
                                    .cornerRadius(12)
                                    .keyboardType(.decimalPad)
                                    .onChange(of: userBodyweight) { oldValue, newValue in
                                        // 1) 숫자와 점(.)만 허용
                                        var filtered = newValue.filter { "0123456789.".contains($0) }
                                        
                                        // 2) 소수점이 2개 이상이면 제거
                                        let dotCount = filtered.filter { $0 == "." }.count
                                        if dotCount > 1 {
                                            if let lastDotIndex = filtered.lastIndex(of: ".") {
                                                filtered.remove(at: lastDotIndex)
                                            }
                                        }
                                        
                                        // 3) 소수점 1자리까지만 허용
                                        if let dotIndex = filtered.firstIndex(of: ".") {
                                            let afterDot = filtered[filtered.index(after: dotIndex)...]
                                            if afterDot.count > 1 {
                                                filtered = String(filtered.prefix(filtered.distance(from: filtered.startIndex, to: dotIndex) + 2))
                                            }
                                        }
                                        
                                        // 4) 앞자리가 0이거나 .으로 시작하는 경우 제거
                                        if filtered.hasPrefix(".") || filtered.hasPrefix("0") {
                                            if filtered.count > 1 && filtered.prefix(2) == "0." {
                                                // "0."은 허용
                                            } else {
                                                // 잘못된 경우 전체 삭제
                                                filtered = ""
                                            }
                                        }
                                        
                                        // 5) 최종적으로 수정된 filtered를 대입
                                        if filtered != newValue {
                                            userBodyweight = filtered
                                        }
                                    }
                                HStack {
                                    Spacer()
                                    XmarkButton(text: $userBodyweight)
                                }
                            }
                            HStack {
                                Text("If bodyweight is not entered, it will be set to 0.")
                                    .font(.setPretendard(weight: .medium, size: 12))
                                    .foregroundStyle(.myBF2418)
                                    .opacity(userBodyweight.count == 0 ? 1 : 0)
                                Spacer()
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
            getUserNickname() // View가 나타날 때 닉네임 로드
            getUserGender() // View가 나타날 때 성별 로드
            getUserBodyweight() // View가 나타날 때 몸무게 로드
            getUserImage() // View가 나타날 때 이미지 로드
        }
        .onTapGesture {
            UIApplication.shared.closeKeyboard()
        }
    }
    /// 기존에 저장된 이미지를 로드해 UI에 표시
    private func getUserImage() {
        let realm = try! Realm()
        if let profile = realm.objects(Profile.self).first, let imgData = profile.image {
            userProfileImage = UIImage(data: imgData)
        }
    }
    
    /// **이미지**를 `Data`로 변환하여 Realm에 저장
    private func setUserImage() {
        guard let image = userProfileImage else { return }
        let realm = try! Realm()
        
        if let existingProfile = realm.objects(Profile.self).first {
            let imgData = image.jpegData(compressionQuality: 0.8)
            try! realm.write {
                existingProfile.image = imgData
            }
        } else {
            let imgData = image.jpegData(compressionQuality: 0.8)
            let newProfile = Profile(
                nickname: userNickname,
                image: imgData,
                gender: userGender,
                bodyWeight: Double(userBodyweight) ?? 0.0
            )
            try! realm.write {
                realm.add(newProfile)
            }
        }
    }
    
    private func getUserBodyweight() {
        let realm = try! Realm()
        
        if let profile = realm.objects(Profile.self).first {
            userBodyweight = String(profile.bodyWeight)
        }
    }
    
    private func setUserBodyweight() {
        let realm = try! Realm()
        
        if let existingBodyweiht = realm.objects(Profile.self).first {
            try! realm.write {
                existingBodyweiht.bodyWeight = Double(userBodyweight) ?? 0.0
            }
            print("⚠️유저 체중 업데이트: \(userBodyweight)")
        }
    }
    
    private func getUserGender() {
        let realm = try! Realm()
        
        if let profile = realm.objects(Profile.self).first {
            userGender = profile.gender
        }
    }
    
    private func setUserGender() {
        let realm = try! Realm()
        
        if let existingGender = realm.objects(Profile.self).first {
            try! realm.write {
                existingGender.gender = userGender
            }
            print("⚠️유저 성별 업데이트: \(userGender)")
        }
    }
    
    private func getUserNickname() {
        let realm = try! Realm()
        
        if let profile = realm.objects(Profile.self).first {
            userNickname = profile.nickname
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
                gender: userGender,
                bodyWeight: Double(userBodyweight) ?? 0.0
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
