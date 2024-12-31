import SwiftUI
import StoreKit
import RealmSwift

struct ProfileView: View {
    
    @Binding var isMainTabbarVisible: Bool
    @ObservedObject var viewModel: BigThreeViewModel
    @State private var profile: Profile? // Profile 데이터를 저장할 변수
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    HStack {
                        Text("Profile")
                            .font(.setPretendard(weight: .bold, size: 34))
                            .foregroundStyle(.white)
                        Spacer()
                        NavigationLink(destination: SettingView(isMainTabbarVisible: $isMainTabbarVisible)) {
                            Image("gear")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    // 상단 타이틀
                    ScrollView {
                        VStack(spacing: 10) {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 112, height: 112)
                            
                            Text("Hello, Lifter")
                                .font(.setPretendard(weight: .semiBold, size: 18))
                                .foregroundStyle(.white)
                                .kerning(2)
                            
                            Text("\(getUserGender()) \(getUserBodyweight())+")
                                .font(.setPretendard(weight: .regular, size: 14))
                                .foregroundStyle(.my1DA4E7)
                                .kerning(1)
                        }
                        
                        HStack(spacing: 10) {
                            VStack(spacing: 0) {
                                Image(systemName: "bolt.fill")
                                    .padding()
                                    .background(.my181A32)
                                    .foregroundStyle(.red)
                                    .clipShape(Circle())
                                    .padding(.vertical)
                                
                                // ⚠️ 나중에 정수형으로 딱 떨어지면, 소수점 표시 X
                                Text("\(viewModel.totalValue, specifier: "%.1f")")
                                    .font(.setPretendard(weight: .bold, size: 24))
                                    .foregroundStyle(.white)
                                    .kerning(0.6)
                                    .padding(.bottom, 4)
                                
                                Text("Total")
                                    .font(.setPretendard(weight: .regular, size: 12))
                                    .foregroundStyle(.myB9B9B9)
                                    .kerning(0.6)
                                    .padding(.bottom)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 166)
                            .background(.myBackBoxcolor)
                            .cornerRadius(12)
                            
                            VStack(spacing: 0) {
                                Image(systemName: "atom")
                                    .padding()
                                    .background(.my181A32)
                                    .foregroundStyle(.yellow)
                                    .clipShape(Circle())
                                    .padding(.vertical)
                                
                                Text("355.5")
                                    .font(.setPretendard(weight: .bold, size: 24))
                                    .foregroundStyle(.white)
                                    .kerning(0.6)
                                    .padding(.bottom, 4)
                                
                                Text("Dots")
                                    .font(.setPretendard(weight: .regular, size: 12))
                                    .foregroundStyle(.myB9B9B9)
                                    .kerning(0.6)
                                    .padding(.bottom)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 166)
                            .background(.myBackBoxcolor)
                            .cornerRadius(12)
                            
                            VStack(spacing: 0) {
                                Image(systemName: "globe")
                                    .padding()
                                    .background(.my181A32)
                                    .foregroundStyle(.blue)
                                    .clipShape(Circle())
                                    .padding(.vertical)
                                
                                Text("360.5")
                                    .font(.setPretendard(weight: .bold, size: 24))
                                    .foregroundStyle(.white)
                                    .kerning(0.6)
                                    .padding(.bottom, 4)
                                
                                Text("Wilks")
                                    .font(.setPretendard(weight: .regular, size: 12))
                                    .foregroundStyle(.myB9B9B9)
                                    .kerning(0.6)
                                    .padding(.bottom)
                                
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 166)
                            .background(.myBackBoxcolor)
                            .cornerRadius(12)
                        }
                        .padding(.top)
                        
                        // MARK: - 기타 정보 영역
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Customer Services")
                                .font(.setPretendard(weight: .semiBold, size: 14))
                                .foregroundStyle(.myB9B9B9)
                                .padding(.bottom, 8)
                            
                            // 앱 버전 정보
                            HStack {
                                Text("My RPE version")
                                    .font(.setPretendard(weight: .regular, size: 16))
                                    .foregroundStyle(.white)
                                Spacer()
                                Text(appVersion)
                                    .font(.setPretendard(weight: .regular, size: 16))
                                    .foregroundStyle(.white)
                            }
                            .padding()
                            .background(Color.myBackBoxcolor)
                            .cornerRadius(8)
                            
                            // 앱 리뷰 남기기
                            HStack {
                                Text("App reviews")
                                    .font(.setPretendard(weight: .regular, size: 16))
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.footnote)
                                    .bold()
                                    .foregroundColor(Color(hex: "555556"))
                            }
                            .padding()
                            .background(Color.myBackBoxcolor)
                            .cornerRadius(8)
                            .onTapGesture {
                                if let scene = UIApplication.shared.connectedScenes
                                    .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                                    SKStoreReviewController.requestReview(in: scene)
                                }
                            }
                            
                            // 의견 및 피드백 남기기
                            HStack {
                                Text("Opinion and feedback")
                                    .font(.setPretendard(weight: .regular, size: 16))
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.footnote)
                                    .bold()
                                    .foregroundColor(Color(hex: "555556"))
                            }
                            .padding()
                            .background(Color.myBackBoxcolor)
                            .cornerRadius(8)
                            .onTapGesture {
                                let urlString = "https://apps.apple.com/app/id6475646908?action=write-review"
                                if let url = URL(string: urlString) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
                            }
                        }
                        .padding(.top, 32)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 68)
            }
            .applyGradientBackground()
        }
    }
    
    // User 체중
    private func getUserGender() -> String {
        let realm = try! Realm()
        
        if let profileData = realm.objects(Profile.self).first {
            let userGender = profileData.gender
            return userGender
        } else {
            print("⚠️ 유저 성별 입력되지 않음")
            return "N/A"
        }
    }
    
    
    // User 체중
    private func getUserBodyweight() -> String {
        let realm = try! Realm()
        
        if let profileData = realm.objects(Profile.self).first {
            let bodyWeight = profileData.bodyWeight
            
            // 소수점이 0인지 확인 후 형식 지정
            let formattedWeight: String
            if bodyWeight.truncatingRemainder(dividingBy: 1) == 0 {
                formattedWeight = String(format: "%.0f", bodyWeight) // 정수로 출력
            } else {
                formattedWeight = String(format: "%.1f", bodyWeight) // 소수점 1자리까지 출력
            }
            return formattedWeight
        } else {
            print("No profile data found. Returning default body weight of 0.0.")
            return "N/A"
        }
    }
    
    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return "\(version)"
    }
}

#Preview {
    ProfileView(isMainTabbarVisible: .constant(true), viewModel: BigThreeViewModel())
}
