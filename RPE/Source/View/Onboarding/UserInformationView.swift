//
//  UserInformationView.swift
//  RPE
//
//  Created by 이상도 on 12/29/24.
//


import SwiftUI
import Realm
import RealmSwift

// MARK: - 앱의 첫 사용시에만 등장하는 뷰
struct UserInformationView: View {
    
    @State private var navigationRouter = NavigationRouter()
    @AppStorage("isFirstRun") private var isFirstRun: Bool?
    @StateObject private var viewModel = BigThreeViewModel()
    @Binding var isPresented: Bool
    
    @State private var showAlert = false
    @State private var isSelectedGender = "Male"
    @State private var bodyWeight: String = ""
    
    var body: some View {
        NavigationStack(path: $navigationRouter.path) {
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
//                        isFirstRun = false
//                        isPresented = false
                    } label: {
                        Text("SKIP")
                            .font(.setPretendard(weight: .semiBold, size: 18))
                            .foregroundStyle(.white)
                    }
                }
                .opacity(0) // 첫 온보딩은 무조건 입력하게
                
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
                                isSelectedGender = "Male"
                            } label: {
                                Text("MALE")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 44)
                                    .font(.setPretendard(weight: isSelectedGender == "Male" ? .bold : .regular, size: 16))
                                    .foregroundStyle(isSelectedGender == "Male" ? .black : .white)
                                    .background(isSelectedGender == "Male" ? .myAccentcolor : .myB9B9B9)
                                    .cornerRadius(12)
                            }
                            
                            Button {
                                isSelectedGender = "Female"
                            } label: {
                                Text("FEMALE")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 44)
                                    .font(.setPretendard(weight: isSelectedGender == "Female" ? .bold : .regular, size: 16))
                                    .foregroundStyle(isSelectedGender == "Female" ? .black : .white)
                                    .background(isSelectedGender == "Female" ? .myAccentcolor : .myB9B9B9)
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
                            setProfileData()
                            UIApplication.shared.closeKeyboard()
                            navigationRouter.push(to: .onboardingView)
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
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .onTapGesture {
                UIApplication.shared.closeKeyboard()
            }
            .navigationDestination(for: PathType.self) { pathType in
                pathType.NavigatingView()
            }
        }
        .environment(navigationRouter)
    }
    
    private func setProfileData() {
        let realm = try! Realm()
        let weight = Double(bodyWeight) ?? 0.0
        let profileImageData = UIImage(named: "default_image")?.jpegData(compressionQuality: 0.8) // 기본 이미지 사용
        
        let profile = Profile(
            nickname: "Hello, Lifter",
            image: profileImageData,
            gender: isSelectedGender,
            bodyWeight: weight
        )
        
        try! realm.write {
            realm.add(profile)
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
    UserInformationView(isPresented: .constant(true))
        .environment(NavigationRouter())
}
